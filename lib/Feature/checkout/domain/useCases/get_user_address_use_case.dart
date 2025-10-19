import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/user_address_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/checkout/domain/repositories/checkout_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';

@injectable
class GetUserAddressUseCase {
  final CheckoutRepo _checkoutRepo;

  GetUserAddressUseCase(this._checkoutRepo);

  Future<ApiResult<UserAddressResponseEntity>> call() {
    return _checkoutRepo.getUserAddress();
  }
}
