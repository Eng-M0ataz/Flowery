import '../../../../../../core/Errors/api_results.dart';
import '../../domain/entities/response/logged_user_data_response_entity.dart';

abstract class ProfileRemoteDataSource {
  Future<ApiResult<LoggedUserDataResponseEntity>>getLoggedUserData();
}