import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../../api/dataSources/profile_main_local_data_source.dart';
import '../../api/models/about_app_model.dart';
import '../../api/models/terms_and_conditions_model.dart';
import '../../domain/repositories/profile_main_repo.dart';
import '../dataSources/profile_main_remote_data_source.dart';

@Injectable(as: ProfileMainRepo)
class ProfileMainRepoImpl implements ProfileMainRepo {
  final ProfileMainRemoteDataSource _profileRemoteDataSource;
  final ProfileMainLocalDataSource _profileLocalDataSource;

  ProfileMainRepoImpl(
    this._profileRemoteDataSource,
    this._profileLocalDataSource,
  );

  @override
  Future<TermsAndConditionsModel> getTermsAndConditions() {
    return _profileLocalDataSource.getTermsAndConditions();
  }

  @override
  Future<AboutAppModel> getAboutApp() {
    return _profileLocalDataSource.getAboutApp();
  }

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() {
    return _profileRemoteDataSource.getLoggedUserData();
  }
}
