import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import '../../domain/entity/request/sign_in_request_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<SigninResponseEntity>> signin({
    required SigninRequestEntity request,
  });
}
