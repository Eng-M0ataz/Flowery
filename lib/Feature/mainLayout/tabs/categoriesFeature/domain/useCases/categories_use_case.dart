import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/repositories/categories_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class CategoriesUseCase {
  final CategoriesRepo _categoriesRepo;
  CategoriesUseCase({required CategoriesRepo categoriesRepo})
      : _categoriesRepo = categoriesRepo;
  Future<ApiResult<CategoryResponseEntity>> invoke() {
    return _categoriesRepo.getAllCategories();
  }
}
