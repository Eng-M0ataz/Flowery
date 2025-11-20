import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';

@injectable
class LogOutUseCase {
  final AuthRepo _authRepo;

  LogOutUseCase(this._authRepo);

  Future<ApiResult<void>> invoke() {
    return _authRepo.logOut();
  }
}
