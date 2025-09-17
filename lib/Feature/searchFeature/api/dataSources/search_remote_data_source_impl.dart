import 'package:flower_e_commerce_app/Feature/searchFeature/api/client/search_api_service.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/models/search_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/api/mapper/search_response_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/data/dataSource/search_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/domain/entities/search_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: SearchRemoteDataSource)
class SearchRemoteDataSourceImpl implements SearchRemoteDataSource {
  final SearchApiService _apiService;
  SearchRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<SearchResponseEntity>> searchProducts(String keyword) async {
    return await executeApi<SearchResponseDto, SearchResponseEntity>(
      request: () => _apiService.searchProducts(keyword),
      mapper: (response) => response.toEntity(),
    );
  }
}
