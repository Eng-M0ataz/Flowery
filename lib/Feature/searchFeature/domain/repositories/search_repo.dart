import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract class SearchRepo {
  Future<ApiResult<SearchResponseEntity>> searchProducts(String keyword);
}
