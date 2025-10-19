import '../../../../core/Errors/api_results.dart';
import '../../domain/entities/request/shipping_address_entity.dart';
import '../../domain/entities/response/user_address_response_entity.dart';
import '../../domain/entities/response/visa_order_entity.dart';

abstract interface class CheckoutRemoteDataSource {
  Future<ApiResult<void>> createCashOrder(
      {required ShippingAddressEntity addressRequest});

  Future<ApiResult<VisaOrderEntity>> createVisaOrder(
      {required ShippingAddressEntity addressRequest});

  Future<ApiResult<UserAddressResponseEntity>> getUserAddress();
}
