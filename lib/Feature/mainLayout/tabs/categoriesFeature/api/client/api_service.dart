import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/category_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/response/product_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/request/get_category_products_request_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'api_service.g.dart';

@injectable
@RestApi()
abstract class ApiServices {
  @factoryMethod
  factory ApiServices(Dio dio) = _ApiServices;

  @GET(ApiConstants.allCategories)
  Future<CategoryResponseDto> getAllCategories();

  @GET(ApiConstants.getProducts)
  Future<ProductResponseDto> getCategoryProductsCategory(
    @Queries() GetProductsByCategoryRequestModel requestModel,
  );

  @GET(ApiConstants.getProducts)
  Future<ProductResponseDto> getAllProducts();
}
