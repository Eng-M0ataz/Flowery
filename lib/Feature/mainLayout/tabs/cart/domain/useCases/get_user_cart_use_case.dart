import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/repositories/cart_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetUserCartUseCase {
  final CartRepo _cartRepository;

  GetUserCartUseCase(this._cartRepository);

  Future<ApiResult<CartEntity>> invoke() async {
    return await _cartRepository.getUserCart();
  }
}
