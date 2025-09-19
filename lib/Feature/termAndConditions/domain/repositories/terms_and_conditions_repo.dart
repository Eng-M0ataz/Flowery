import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/entities/terms_and_conditions_entity.dart';

abstract class TermsAndConditionsRepository {
  Future<List<TermsAndConditionsEntity>> fetchSections(String locale);
}