import 'package:flower_e_commerce_app/Feature/mainLayout/api/models/response/occasion_response_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
import 'package:dio/dio.dart';
import '../models/response/product_by_occasion_response_dto.dart';

part 'occasion_api_service.g.dart';

@RestApi()
@injectable
abstract class OccasionApiService {
  @factoryMethod
  factory OccasionApiService(Dio dio) = _OccasionApiService;

  @GET(ApiConstants.occasions)
  Future<OccasionResponseDto> getAllOccasions();

  @GET(ApiConstants.products)
  Future<ProductByOccasionResponseDto> getProductsByOccasion(
    @Query(ApiConstants.occasionQuery) String occasionId,
  );
}
