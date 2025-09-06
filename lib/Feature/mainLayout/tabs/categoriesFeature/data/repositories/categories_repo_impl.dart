import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/dataSources/categories_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/repositories/categories_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRepo)
class CategoriesRepoImpl implements CategoriesRepo {
  final CategoriesRemoteDataSource _categoriesRemoteDataSource;
  CategoriesRepoImpl(
      {required CategoriesRemoteDataSource categoriesRemoteDataSource})
      : _categoriesRemoteDataSource = categoriesRemoteDataSource;
  @override
  Future<ApiResult<CategoryResponseEntity>> getAllCategories() {
    return _categoriesRemoteDataSource.getAllCategories();
  }

  @override
  Future<ApiResult<ProductResponseEntity>> getCategoryProducts(
      GetCategoryProductsRequestModel getCategoryProductsRequestModel) {
    return _categoriesRemoteDataSource
        .getCategoryProducts(getCategoryProductsRequestModel);
  }

  @override
  Future<ApiResult<ProductResponseEntity>> getAllProducts() {
    return _categoriesRemoteDataSource.getAllProducts();
  }
}
