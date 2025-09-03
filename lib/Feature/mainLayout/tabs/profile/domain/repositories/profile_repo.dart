import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import '../entities/response/logged_user_data_response_entity.dart';

abstract class ProfileRepo {
  Future<ApiResult<LoggedUserDataResponseEntity>>getLoggedUserData();
}