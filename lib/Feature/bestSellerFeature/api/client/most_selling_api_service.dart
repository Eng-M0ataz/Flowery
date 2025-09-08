import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/api/models/response/best_seller_response_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';
part 'most_selling_api_service.g.dart';

@RestApi()
@injectable
abstract class MostSellingApiService{
  @factoryMethod
  factory MostSellingApiService(Dio dio) = _MostSellingApiService;

  @GET(ApiConstants.mostSelling)
  Future<BestSellerResponseDto> getBestSeller();
}