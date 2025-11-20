import '../models/about_app_model.dart';
import '../models/terms_and_conditions_model.dart';

abstract interface class ProfileMainLocalDataSource {
  Future<TermsAndConditionsModel> getTermsAndConditions();

  Future<AboutAppModel> getAboutApp();
}
