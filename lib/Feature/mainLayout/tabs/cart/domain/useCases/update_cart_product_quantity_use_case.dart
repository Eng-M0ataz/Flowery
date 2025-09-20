import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/repositories/cart_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCartProductQuantityUseCase {
  final CartRepo _cartRepositories;

  UpdateCartProductQuantityUseCase(this._cartRepositories);

  Future<ApiResult<void>> invoke({
    required UpdateCartQuantityInput quantity,
    required String productId,
  }) async {
    return await _cartRepositories.updateCartProductQuantity(
      quantity: quantity,
      productId: productId,
    );
  }
}
