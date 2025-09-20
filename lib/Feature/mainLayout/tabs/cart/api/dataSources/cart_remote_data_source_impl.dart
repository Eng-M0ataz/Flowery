import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/client/cart_api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/mappers/cart_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/update_cart_quantity_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/data/dataSources/cart_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRemoteDataSource)
class CartRemoteDataSourceImpl implements CartRemoteDataSource {
  final CartApiService _apiService;

  CartRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<void>> clearSpecificCartItem({
    required String productId,
  }) async {
    return executeApi<void, void>(
      request: () => _apiService.clearSpecificCartItem(productId: productId),
      mapper: null,
    );
  }

  @override
  Future<ApiResult<void>> clearUserCart() {
    return executeApi<void, void>(
      request: () => _apiService.clearUserCart(),
      mapper: null,
    );
  }

  @override
  Future<ApiResult<CartEntity>> getUserCart() async {
    return executeApi<CartResponseDto, CartEntity>(
      request: () => _apiService.getUserCart(),
      mapper: (response) => response.toEntity(),
    );
  }

  @override
  Future<ApiResult<void>> updateCartProductQuantity({
    required String productId,
    required UpdateCartQuantityInput quantity,
  }) {
    return executeApi<void, void>(
      request: () => _apiService.updateCartProductQuantity(
        productId: productId,
        updateCartQuantityDto: quantity,
      ),
      mapper: null,
    );
  }
}
