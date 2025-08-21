import 'package:flower_e_commerce_app/Feature/auth/domain/entities/requestEntities/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class AuthRepo {
  Future<ApiResult<SignUpResponseEntity>> signUp(
      SignUpRequestEntity signUpRequestEntity);
}
