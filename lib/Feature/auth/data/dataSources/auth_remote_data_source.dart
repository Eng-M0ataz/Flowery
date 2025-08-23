import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/sign_in_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import '../../domain/entities/request/forget_password_request_entity.dart';
import '../../domain/entities/request/reset_password_request_entity.dart';
import '../../domain/entities/request/verify_reset_code_request_entity.dart';
import '../../domain/entities/response/forget_password_response_entity.dart';
import '../../domain/entities/response/reset_password_response_entity.dart';
import '../../domain/entities/response/verify_reset_code_response_entity.dart';

abstract interface class AuthRemoteDataSource {
  Future<ApiResult<SignUpResponseEntity>> signup(
      SignUpRequestEntity signUpRequestEntity);

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
    required String email,
    required String password,
  });
}
