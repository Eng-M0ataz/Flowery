import 'package:injectable/injectable.dart';
import '../../api/models/about_app_model.dart';
import '../repositories/profile_main_repo.dart';
@injectable
class GetAboutAppUseCase {
  final ProfileMainRepo _repo;

  GetAboutAppUseCase(this._repo);

  Future<AboutAppModel> invoke() {
    return _repo.getAboutApp();
  }
}
