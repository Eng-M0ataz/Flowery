import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/entities/terms_and_conditions_entity.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/repositories/terms_and_conditions_repo.dart';
import 'package:injectable/injectable.dart';

@injectable
class TermsAndConditionsUseCase {
  final TermsAndConditionsRepository repo;
  TermsAndConditionsUseCase(this.repo);

  Future<List<TermsAndConditionsEntity>> invoke(String locale) {
    return repo.fetchSections(locale);
  }
}