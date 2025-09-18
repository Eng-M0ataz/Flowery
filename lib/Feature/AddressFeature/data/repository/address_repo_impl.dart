import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/request/add_address_request_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/data/dataSources/address_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/data/dataSources/address_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/repositories/address_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressRepo)
class AddressRepoImpl implements AddressRepo {
  final AddressRemoteDataSource _addressRemoteDataSource;
  final AddressLocalDataSource _addressLocalDataSource;
  AddressRepoImpl(
      {required AddressRemoteDataSource addressRemoteDataSource,
      required AddressLocalDataSource addressLocalDataSource})
      : _addressRemoteDataSource = addressRemoteDataSource,
        _addressLocalDataSource = addressLocalDataSource;

  @override
  Future<List<CityEntity>> getCities() {
    return _addressLocalDataSource.getCities();
  }

  @override
  Future<List<CityEntity>> getCitiesByGovernorateId(int governorateId) {
    return _addressLocalDataSource.getCitiesByGovernorateId(governorateId);
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() {
    return _addressLocalDataSource.getGovernorates();
  }

  @override
  Future<ApiResult<AddressResponseEntity>> getAddresses() {
    return _addressRemoteDataSource.getAddresses();
  }

  @override
  Future<ApiResult<void>> deleteAddress(String addressId) {
    return _addressRemoteDataSource.deleteAddress(addressId);
  }

  @override
  Future<ApiResult<AddressResponseEntity>> addAddress(
      AddAddressRequestModel addAddressRequestModel) {
    return _addressRemoteDataSource.addAddress(addAddressRequestModel);
  }

  @override
  Future<ApiResult<AddressResponseEntity>> updateAddress(
      String addressId, AddAddressRequestModel addAddressRequestModel) {
    return _addressRemoteDataSource.updateAddress(
        addressId, addAddressRequestModel);
  }
}
