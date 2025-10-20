import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/request/shipping_address_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/cash_order_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/visa_order_entity.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/response/user_address_response_entity.dart';

abstract interface class CheckoutRepo {
  Future<ApiResult<CashOrderEntity>> createCashOrder(
      {required ShippingAddressEntity addressRequest});

  Future<ApiResult<VisaOrderEntity>> createVisaOrder(
      {required ShippingAddressEntity addressRequest});

  Future<ApiResult<UserAddressResponseEntity>> getUserAddress();
}
