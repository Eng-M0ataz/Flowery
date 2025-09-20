import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/request/add_address_request_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/response/address_response_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'address_api_service.g.dart';

@injectable
@RestApi()
abstract class AddressApiServices {
  @factoryMethod
  factory AddressApiServices(Dio dio) = _AddressApiServices;

  @GET(ApiConstants.addresses)
  Future<AddressResponseDto> getAddresses();

  @DELETE(ApiConstants.addressById)
  Future<void> deleteAddress(@Path(ApiConstants.id) String addressId);

  @PATCH(ApiConstants.addresses)
  Future<AddressResponseDto> addAddress(
      @Body() AddAddressRequestModel addAddressRequestModel);

  @PATCH(ApiConstants.addressById)
  Future<AddressResponseDto> updateAddress(
      @Path(ApiConstants.id) String addressId,
      @Body() AddAddressRequestModel addAddressRequestModel);
}
