import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/repositories/categories_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUseCase {
  final CategoriesRepo _categoriesRepo;
  GetAllProductsUseCase({required CategoriesRepo categoriesRepo})
      : _categoriesRepo = categoriesRepo;
  Future<ApiResult<ProductResponseEntity>> invoke() {
    return _categoriesRepo.getAllProducts();
  }
}
