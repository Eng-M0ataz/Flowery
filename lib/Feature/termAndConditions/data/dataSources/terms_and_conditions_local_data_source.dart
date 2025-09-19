import 'package:flower_e_commerce_app/Feature/termAndConditions/local/model/terms_and_conditions_model.dart';

abstract class TermsAndConditionsLocalDataSource {
  Future<List<TermsAndConditionsModel>> getSections();
}