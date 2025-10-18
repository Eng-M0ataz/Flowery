import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_request_body_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract class TrackMapRepo {
  Future<ApiResult<RouteResponseEntity>> getRoute({
    required String apiKey,
    required String fieldMask,
    required RouteRequestBodyDto body,
  });
}
