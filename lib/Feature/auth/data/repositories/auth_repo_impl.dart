import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/Entity/sign_in_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  final AuthLocalDataSource _authLocalDataSource;
  AuthRepoImpl(
      this._authRemoteDataSource,
      this._authLocalDataSource
      );

  @override
  Future<ApiResult<SigninResponseEntity>> signin({
    required String email,
    required String password,
    bool? rememberMeChecked = false
  }) async {

    // final ApiSuccessResult result = ApiSuccessResult(data: data);

      ApiResult<SigninResponseEntity> result = await _authRemoteDataSource.signin(
          email: email,
          password: password
      );

      if(result is ApiSuccessResult<SigninResponseEntity>) {
        final String? token = result.data.token;
        if(token != null && token.isNotEmpty) {
          await _authLocalDataSource.writeToken(token: token);

          // If user checked "Remember Me"
          if (rememberMeChecked!) {
            await _authLocalDataSource.setRememberMe(rememberMe: true);
          }
        }
      }
      return result;
  }
}
