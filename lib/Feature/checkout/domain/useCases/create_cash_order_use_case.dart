import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/request/shipping_address_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/repositories/checkout_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';

@injectable
class CreateCashOrderUseCase {
  final CheckoutRepo _checkoutRepo;

  CreateCashOrderUseCase(this._checkoutRepo);

  Future<ApiResult<void>> call({required ShippingAddressEntity addressRequest}) {
    return _checkoutRepo.createCashOrder(addressRequest: addressRequest);
  }
}
