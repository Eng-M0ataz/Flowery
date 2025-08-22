import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/Entity/sign_in_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteDataSource _authRemoteDataSource;
  AuthRepoImpl(this._authRemoteDataSource);

  @override
  Future<ApiResult<SigninResponseEntity>> signin({
    required String email,
    required String password
  }) {

    return _authRemoteDataSource.signin(
        email: email,
        password: password
    );
  }
}
