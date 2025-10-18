import 'package:flower_e_commerce_app/Feature/trackMap/api/client/track_map_api_service.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/mapper/route_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_request_body_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/data/dataSources/track_map_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: TrackMapRemoteDataSource)
class TrackMapRemoteDataSourceImpl implements TrackMapRemoteDataSource {
  final TrackMapApiService _apiService;

  TrackMapRemoteDataSourceImpl(this._apiService);

  @override
  Future<ApiResult<RouteResponseEntity>> getRoute({
    required String apiKey,
    required String fieldMask,
    required RouteRequestBodyDto body,
  }) async {
    return await executeApi<RouteResponseDto, RouteResponseEntity>(
      request: () => _apiService.getRoute(apiKey, fieldMask, body),
      mapper: (response) => response.toEntity(),
    );
  }
}
