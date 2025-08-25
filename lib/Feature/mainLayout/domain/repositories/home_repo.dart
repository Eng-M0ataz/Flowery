import 'package:flower_e_commerce_app/Feature/mainLayout/domain/entities/response/occasion_response_entity.dart';
import '../../../../core/Errors/api_results.dart';

abstract interface class HomeRepo {
  Future<ApiResult<OccasionResponseEntity>>getAllOccasions();
}