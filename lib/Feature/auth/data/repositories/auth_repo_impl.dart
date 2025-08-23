import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/request/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../../domain/entities/request/forget_password_request_entity.dart';
import '../../domain/entities/request/reset_password_request_entity.dart';
import '../../domain/entities/request/verify_reset_code_request_entity.dart';
import '../../domain/entities/response/forget_password_response_entity.dart';
import '../../domain/entities/response/reset_password_response_entity.dart';
import '../../domain/entities/response/verify_reset_code_response_entity.dart';
import '../dataSources/auth_remote_data_source.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthLocalDataSource _authLocalDataSource;
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepoImpl({
    required AuthRemoteDataSource authRemoteDataSource,
    required AuthLocalDataSource authLocalDataSource,
  })  : _authLocalDataSource = authLocalDataSource,
        _authRemoteDataSource = authRemoteDataSource;

  @override
  Future<ApiResult<SignUpResponseEntity>> signUp(
      SignUpRequestEntity signUpRequestEntity) {
    return _authRemoteDataSource.signup(signUpRequestEntity);
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
  Future<ApiResult<void>> isGuest() async {
    return await _authLocalDataSource.isGuest();
  }
}
