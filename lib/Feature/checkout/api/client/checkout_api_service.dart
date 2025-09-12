import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/cash_order_dto.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/user_address_dto.dart';
import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/visa_order_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../models/request/shipping_address_request_dto.dart';

part 'checkout_api_service.g.dart';

@RestApi()
@injectable
abstract class CheckoutApiService {
  @factoryMethod
  factory CheckoutApiService(Dio dio) = _CheckoutApiService;

  @POST(ApiConstants.cashOrder)
  Future<CashOrderDto> createCashOrder(
    @Body() ShippingAddressRequestDto body,
  );

  @POST(ApiConstants.visaOrder)
  Future<VisaOrderDto> createVisaOrder(
    @Body() ShippingAddressRequestDto body,
  );

  @GET(ApiConstants.addresses)
  Future<UserAddressDto> getUserAddress();
}
