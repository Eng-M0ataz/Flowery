import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../entities/response/add_product_response_entity.dart';
import '../repositories/occasion_repo.dart';

@injectable
class AddProductToCartUseCase {
  final OccasionRepo _occasionRepo;

  AddProductToCartUseCase(this._occasionRepo);

  Future<ApiResult<AddProductResponseEntity>> invoke(String productId) {
    return _occasionRepo.addProductToCart(productId);
  }
}
