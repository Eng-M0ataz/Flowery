import 'package:flower_e_commerce_app/Feature/auth/data/dataSources/auth_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
 final AuthLocalDataSource _authLocalDataSource;
 AuthRepoImpl(this._authLocalDataSource);

  @override
  Future <ApiResult<void>> isGuest()async {

   return await _authLocalDataSource.isGuest();
  }


}
