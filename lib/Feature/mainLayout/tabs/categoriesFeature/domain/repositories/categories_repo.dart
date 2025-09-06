import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class CategoriesRepo {
  Future<ApiResult<CategoryResponseEntity>> getAllCategories();
  Future<ApiResult<ProductResponseEntity>> getAllProducts();
  Future<ApiResult<ProductResponseEntity>> getProductsByCategory(
      GetProductsByCategoryRequestModel getCategoryProductsRequestModel);
}
