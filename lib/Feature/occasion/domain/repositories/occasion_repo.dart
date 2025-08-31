import '../../../../core/Errors/api_results.dart';
import '../entities/response/occasion_response_entity.dart';
import '../entities/response/product_by_occasion_response_entity.dart';

abstract interface class OccasionRepo {
  Future<ApiResult<OccasionResponseEntity>> getAllOccasions();

  Future<ApiResult<ProductByOccasionResponseEntity>> getProductsByOccasion(
    String occasionId,
  );
}
