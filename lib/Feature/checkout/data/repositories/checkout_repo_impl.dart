import 'package:flower_e_commerce_app/Feature/checkout/data/dataSources/checkout_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/request/shipping_address_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/cash_order_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/user_address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/visa_order_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/repositories/checkout_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';

@Injectable(as: CheckoutRepo)
class CheckoutRepoImpl implements CheckoutRepo {
  final CheckoutRemoteDataSource _checkoutRemoteDataSource;

  CheckoutRepoImpl(this._checkoutRemoteDataSource);

  @override
  Future<ApiResult<CashOrderEntity>> createCashOrder(
      {required ShippingAddressEntity addressRequest}) {
    return _checkoutRemoteDataSource.createCashOrder(
        addressRequest: addressRequest);
  }

  @override
  Future<ApiResult<VisaOrderEntity>> createVisaOrder(
      {required ShippingAddressEntity addressRequest}) {
    return _checkoutRemoteDataSource.createVisaOrder(
        addressRequest: addressRequest);
  }

  @override
  Future<ApiResult<UserAddressResponseEntity>> getUserAddress() {
    return _checkoutRemoteDataSource.getUserAddress();
  }
}
