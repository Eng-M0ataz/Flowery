import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../domain/repositories/profile_repo.dart';

@Injectable(as: ProfileRepo)
class ProfileRepoImpl implements ProfileRepo {
  final ProfileRemoteDataSource _profileRemoteDataSource;

  ProfileRepoImpl(this._profileRemoteDataSource);

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() {
    return _profileRemoteDataSource.getLoggedUserData();
  }
}
