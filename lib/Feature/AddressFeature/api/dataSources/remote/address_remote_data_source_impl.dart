import 'package:flower_e_commerce_app/Feature/AddressFeature/api/client/address_api_service.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/mapper/address_mapper.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/request/add_address_request_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/response/address_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/data/dataSources/address_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRemoteDataSource)
class AddressRemoteDataSourceImpl implements AddressRemoteDataSource {
  final AddressApiServices _addressApiServices;

  AddressRemoteDataSourceImpl({
    required AddressApiServices apiServicest,
  }) : _addressApiServices = apiServicest;

  @override
  Future<ApiResult<AddressResponseEntity>> getAddresses() async {
    return executeApi<AddressResponseDto, AddressResponseEntity>(
      request: () => _addressApiServices.getAddresses(),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<void>> deleteAddress(String addressId) async {
    return executeApi<void, void>(
      request: () => _addressApiServices.deleteAddress(addressId),
      mapper: (response) => response,
    );
  }

  @override
  Future<ApiResult<AddressResponseEntity>> addAddress(
      AddAddressRequestModel addAddressRequestModel) {
    return executeApi<AddressResponseDto, AddressResponseEntity>(
      request: () => _addressApiServices.addAddress(addAddressRequestModel),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<AddressResponseEntity>> updateAddress(
      String addressId, AddAddressRequestModel addAddressRequestModel) {
    return executeApi<AddressResponseDto, AddressResponseEntity>(
      request: () =>
          _addressApiServices.updateAddress(addressId, addAddressRequestModel),
      mapper: (response) => response.toEntity(),
    );
  }
}
