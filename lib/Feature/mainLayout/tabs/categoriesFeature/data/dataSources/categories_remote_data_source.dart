import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/resposneEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class CategoriesRemoteDataSource {
  Future<ApiResult<CategoryResponseEntity>> getAllCategories();
}
