import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/repositories/search_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductSearchUseCase {
  final SearchRepo _repo;
  ProductSearchUseCase(this._repo);

  Future<ApiResult<SearchResponseEntity>> invoke(String keyword) {
    return _repo.searchProducts(keyword);
  }
}
