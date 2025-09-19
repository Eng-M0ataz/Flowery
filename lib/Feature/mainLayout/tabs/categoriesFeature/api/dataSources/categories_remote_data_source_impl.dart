import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/client/api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/category_response_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/mapper/product_response_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/category_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/product_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/data/dataSources/categories_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/categories_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/responseEntities/product_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CategoriesRemoteDataSource)
class CategoriesRemoteDataSourceImpl implements CategoriesRemoteDataSource {
  final ApiServices _apiServices;

  CategoriesRemoteDataSourceImpl({
    required ApiServices apiServicest,
  }) : _apiServices = apiServicest;

  @override
  Future<ApiResult<CategoryResponseEntity>> getAllCategories() async {
    return executeApi<CategoryResponseDto, CategoryResponseEntity>(
      request: () => _apiServices.getAllCategories(),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<ProductResponseEntity>> getProductsByCategory(
      GetProductsByCategoryRequestModel requestModel) async {
    return executeApi<ProductResponseDto, ProductResponseEntity>(
      request: () => _apiServices.getCategoryProductsCategory(requestModel),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<ProductResponseEntity>> getAllProducts() async {
    return executeApi<ProductResponseDto, ProductResponseEntity>(
      request: () => _apiServices.getAllProducts(),
      mapper: (dto) => dto.toEntity(),
    );
  }
}
