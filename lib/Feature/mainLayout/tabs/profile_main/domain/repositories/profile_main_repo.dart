import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import '../../api/models/about_app_model.dart';
import '../../api/models/terms_and_conditions_model.dart';
import '../entities/response/logged_user_data_response_entity.dart';

abstract class ProfileMainRepo {
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData();

  Future<TermsAndConditionsModel> getTermsAndConditions();

  Future<AboutAppModel> getAboutApp();
}
