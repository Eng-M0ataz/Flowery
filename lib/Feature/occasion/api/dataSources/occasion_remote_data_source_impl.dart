import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/occasion_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/product_by_occasion_mapper.dart';
import 'package:flower_e_commerce_app/Feature/occasion/api/models/response/occasion_response_dto.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';
import '../../data/dataSources/occasion_remote_data_source.dart';
import '../../domain/entities/response/occasion_response_entity.dart';
import '../../domain/entities/response/product_by_occasion_response_entity.dart';
import '../client/occasion_api_service.dart';
import '../models/response/product_by_occasion_response_dto.dart';

@Injectable(as: OccasionRemoteDataSource)
class OccasionRemoteDataSourceImpl implements OccasionRemoteDataSource {
  final OccasionApiService _apiService;

  OccasionRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<OccasionResponseEntity>> getAllOccasions() async {
    return executeApi<OccasionResponseDto, OccasionResponseEntity>(
      request: () => _apiService.getAllOccasions(),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<ProductByOccasionResponseEntity>> getProductsByOccasion(
      String occasionId) {
    return executeApi<ProductByOccasionResponseDto,
        ProductByOccasionResponseEntity>(
      request: () => _apiService.getProductsByOccasion(occasionId),
      mapper: (dto) => dto.toEntity(),
    );
  }
}
