import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class CategoriesRemoteDataSource {
  Future<ApiResult<CategoryResponseEntity>> getAllCategories();

  Future<ApiResult<ProductResponseEntity>> getCategoryProducts(
      GetCategoryProductsRequestModel getCategoryProductsRequestModel);

  Future<ApiResult<ProductResponseEntity>> getAllProducts();
}
