import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/requestEntities/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

import '../../domain/entities/request/forget_password_request_entity.dart';
import '../../domain/entities/request/reset_password_request_entity.dart';
import '../../domain/entities/request/verify_reset_code_request_entity.dart';
import '../../domain/entities/response/forget_password_response_entity.dart';
import '../../domain/entities/response/reset_password_response_entity.dart';
import '../../domain/entities/response/verify_reset_code_response_entity.dart';
import '../../domain/entity/response/sign_in_response_entity.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;

  final AuthLocalDataSource _authLocalDataSource;
  AuthRepoImpl(this._authRemoteDataSource, this._authLocalDataSource);

  @override
  Future<ApiResult<SigninResponseEntity>> signin(
      {required SigninRequestEntity request,
      bool? rememberMeChecked = false}) async {
    ApiResult<SigninResponseEntity> result =
        await _authRemoteDataSource.signin(request: request);

    if (result is ApiSuccessResult<SigninResponseEntity>) {
      final String? token = result.data.token;
      if (token != null && token.isNotEmpty) {
        await _authLocalDataSource.writeToken(token: token);

        // If user checked "Remember Me"
        if (rememberMeChecked!) {
          await _authLocalDataSource.setRememberMe(rememberMe: true);
        }
      }
    }
    return result;
  }

  @override
  Future<ApiResult<ForgetPasswordResponseEntity>> forgetPassword(
    ForgetPasswordRequestEntity request,
  ) {
    return _authRemoteDataSource.forgetPassword(request);
  }

  @override
  Future<ApiResult<VerifyResetCodeResponseEntity>> verifyResetCode(
    VerifyResetCodeRequestEntity request,
  ) {
    return _authRemoteDataSource.verifyResetCode(request);
  }

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
    ResetPasswordRequestEntity request,
  ) {
    return _authRemoteDataSource.resetPassword(request);
  }

  @override
  Future<ApiResult<SignUpResponseEntity>> signUp(
      SignUpRequestEntity signUpRequestEntity) {
    return _authRemoteDataSource.signup(signUpRequestEntity);
  }

  @override
  Future<ApiResult<void>> logOut() {
    return _authLocalDataSource.logOut();
  }
}
