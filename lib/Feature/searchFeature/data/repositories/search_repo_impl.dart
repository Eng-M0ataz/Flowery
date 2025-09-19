import 'package:flower_e_commerce_app/Feature/searchFeature/data/dataSource/search_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/repositories/search_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  final SearchRemoteDataSource _dataSource;
  SearchRepoImpl(this._dataSource);

  @override
  Future<ApiResult<SearchResponseEntity>> searchProducts(String keyword) async {
    return await _dataSource.searchProducts(keyword);
  }
}
