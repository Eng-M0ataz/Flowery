import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract class CartRepo {
  Future<ApiResult<CartEntity>> getUserCart();
  Future<ApiResult<void>> updateCartProductQuantity({
    required UpdateCartQuantityInput quantity,
    required String productId,
  });
  Future<ApiResult<void>> clearSpecificCartItem({required String productId});
  Future<ApiResult<void>> clearUserCart();
}
