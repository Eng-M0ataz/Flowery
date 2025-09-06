import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import '../entity/request/sign_in_request_entity.dart';
import '../entity/response/sign_in_response_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<SigninResponseEntity>> signin(
      {required SigninRequestEntity request, bool? rememberMeChecked});
}
