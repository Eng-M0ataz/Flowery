import '../../../../core/Errors/api_results.dart';
import '../../domain/entities/response/add_product_response_entity.dart';
import '../../domain/entities/response/occasion_response_entity.dart';
import '../../domain/entities/response/product_by_occasion_response_entity.dart';

abstract interface class OccasionRemoteDataSource {
  Future<ApiResult<OccasionResponseEntity>> getAllOccasions();

  Future<ApiResult<ProductByOccasionResponseEntity>> getProductsByOccasion(
    String occasionId,
  );
  Future<ApiResult<AddProductResponseEntity>> addProductToCart(
      String productId,
      );
}
