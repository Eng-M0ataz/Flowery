import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_response_dto.dart';
import 'package:flower_e_commerce_app/core/utils/constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
part 'search_api_service.g.dart';

@RestApi()
@injectable
abstract class SearchApiService {
  @factoryMethod
  factory SearchApiService(Dio dio) = _SearchApiService;

  @GET(ApiConstants.products)
  Future<SearchResponseDto> searchProducts(
      @Query(ApiConstants.keywordQuery) String keyword);
}
