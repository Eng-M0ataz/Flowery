import '../../../../../../core/Errors/api_results.dart';
import '../../domain/entities/response/logged_user_data_response_entity.dart';

abstract class ProfileMainRemoteDataSource {
  Future<ApiResult<LoggedUserDataResponseEntity>>getLoggedUserData();
}