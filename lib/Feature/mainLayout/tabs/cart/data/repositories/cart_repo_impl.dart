import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/data/dataSources/cart_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/repositories/cart_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepo)
class CartRepoImpl implements CartRepo {
  final CartRemoteDataSource _cartRemoteDataSource;

  CartRepoImpl(this._cartRemoteDataSource);

  @override
  Future<ApiResult<void>> clearSpecificCartItem({required String productId}) {
    return _cartRemoteDataSource.clearSpecificCartItem(productId: productId);
  }

  @override
  Future<ApiResult<void>> clearUserCart() {
    return _cartRemoteDataSource.clearUserCart();
  }

  @override
  Future<ApiResult<CartEntity>> getUserCart() {
    return _cartRemoteDataSource.getUserCart();
  }

  @override
  Future<ApiResult<void>> updateCartProductQuantity({
    required UpdateCartQuantityInput quantity,
    required String productId,
  }) {
    return _cartRemoteDataSource.updateCartProductQuantity(
      quantity: quantity,
      productId: productId,
    );
  }
}
