

import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class GuestUseCase{
  final AuthRepo _authRepo;
  GuestUseCase(this._authRepo);

  Future<ApiResult>isGuest() async {
    return _authRepo.isGuest();
  }

}