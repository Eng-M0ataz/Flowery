import 'package:injectable/injectable.dart';
import '../../api/models/terms_and_conditions_model.dart';
import '../repositories/profile_main_repo.dart';
@injectable
class GetTermsAndConditionsUseCase {
  final ProfileMainRepo _repo;

  GetTermsAndConditionsUseCase(this._repo);

  Future<TermsAndConditionsModel> invoke() {
    return _repo.getTermsAndConditions();
  }
}
