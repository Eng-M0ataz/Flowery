import 'package:flower_e_commerce_app/Feature/auth/domain/entities/requestEntities/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

import '../entities/request/forget_password_request_entity.dart';
import '../entities/request/reset_password_request_entity.dart';
import '../entities/request/verify_reset_code_request_entity.dart';
import '../entities/response/forget_password_response_entity.dart';
import '../entities/response/reset_password_response_entity.dart';
import '../entities/response/verify_reset_code_response_entity.dart';
import '../entity/request/sign_in_request_entity.dart';
import '../entity/response/sign_in_response_entity.dart';

abstract interface class AuthRepo {
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  );

  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode(
    VerifyResetCodeRequestEntity request,
  );

  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  );
  Future<ApiResult<SigninResponseEntity>> signin({
    required SigninRequestEntity request,
    bool? rememberMeChecked,
  });
  Future<ApiResult<SignUpResponseEntity>> signUp(
    SignUpRequestEntity signUpRequestEntity,
  );
  Future<ApiResult<void>> logOut();
}
