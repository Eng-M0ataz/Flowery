import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../domain/entities/response/logged_user_data_response_entity.dart';
import '../../domain/repositories/profile_main_repo.dart';
import '../dataSources/profile_main_remote_data_source.dart';

@Injectable(as: ProfileMainRepo)
class ProfileMainRepoImpl implements ProfileMainRepo {
  final ProfileMainRemoteDataSource _profileRemoteDataSource;

  ProfileMainRepoImpl(this._profileRemoteDataSource);

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() {
    return _profileRemoteDataSource.getLoggedUserData();
  }
}
