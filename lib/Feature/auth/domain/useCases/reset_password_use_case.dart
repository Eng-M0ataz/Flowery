import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/request/reset_password_request_entity.dart';
import '../entities/response/reset_password_response_entity.dart';
import '../repositories/auth_repo.dart';

@injectable
class ResetPasswordUseCase {
  final AuthRepo _authRepo;

  ResetPasswordUseCase(this._authRepo);

  Future<ApiResult<ResetPasswordResponseEntity>> invoke(
    ResetPasswordRequestEntity request,
  ) {
    return _authRepo.resetPassword(request);
  }
}
