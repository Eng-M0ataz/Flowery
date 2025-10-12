import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract class CartRemoteDataSource {
  Future<ApiResult<CartEntity>> getUserCart();
  Future<ApiResult<void>> updateCartProductQuantity({
    required String productId,
    required UpdateCartQuantityInput quantity,
  });
  Future<ApiResult<void>> clearSpecificCartItem({required String productId});
  Future<ApiResult<void>> clearUserCart();
}
