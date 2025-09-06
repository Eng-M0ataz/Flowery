import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/repositories/categories_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCategoryProductsUseCase {
  final CategoriesRepo _categoriesRepo;
  GetCategoryProductsUseCase({required CategoriesRepo categoriesRepo})
      : _categoriesRepo = categoriesRepo;
  Future<ApiResult<ProductResponseEntity>> invoke(
      {required String? categoryId, required int? page, required int? limit}) {
    return _categoriesRepo.getCategoryProducts(GetCategoryProductsRequestModel(
      categoryId: categoryId ?? '',
      page: page,
      limit: limit,
    ));
  }
}
