import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_request_body_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/repositories/track_map_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetRouteUseCase {
  final TrackMapRepo _repo;

  GetRouteUseCase(this._repo);

  Future<ApiResult<RouteResponseEntity>> call({
    required String apiKey,
    required String fieldMask,
    required RouteRequestBodyDto body,
  }) async {
    return await _repo.getRoute(
      apiKey: apiKey,
      fieldMask: fieldMask,
      body: body,
    );
  }
}
