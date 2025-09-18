import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/request/add_address_request_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class AddressRepo {
  Future<List<GovernorateEntity>> getGovernorates();
  Future<List<CityEntity>> getCities();
  Future<List<CityEntity>> getCitiesByGovernorateId(int governorateId);
  Future<ApiResult<AddressResponseEntity>> getAddresses();
  Future<ApiResult<void>> deleteAddress(String addressId);
  Future<ApiResult<AddressResponseEntity>> addAddress(
      AddAddressRequestModel addAddressRequestModel);

  Future<ApiResult<AddressResponseEntity>> updateAddress(
    String addressId,
    AddAddressRequestModel addAddressRequestModel,
  );
}
