import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/repositories/cart_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class ClearSpecificCartItemUseCase {
  final CartRepo _cartRepositories;

  ClearSpecificCartItemUseCase(this._cartRepositories);

  Future<ApiResult<void>> invoke({required String productId}) async {
    return await _cartRepositories.clearSpecificCartItem(productId: productId);
  }
}
