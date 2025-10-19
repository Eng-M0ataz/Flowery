import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/request/shipping_address_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/visa_order_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/repositories/checkout_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';

@injectable
class CreateVisaOrderUseCase {
  final CheckoutRepo _checkoutRepo;

  CreateVisaOrderUseCase(this._checkoutRepo);

  Future<ApiResult<VisaOrderEntity>> call(
      {required ShippingAddressEntity addressRequest}) {
    return _checkoutRepo.createVisaOrder(addressRequest: addressRequest);
  }
}
