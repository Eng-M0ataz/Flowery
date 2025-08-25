import '../../../../core/Errors/api_results.dart';
import '../../domain/entities/response/occasion_response_entity.dart';

abstract interface class HomeRemoteDataSource {
  Future<ApiResult<OccasionResponseEntity>>getAllOccasions();
}