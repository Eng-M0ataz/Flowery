import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../../api/model/request/reset_password_request_model.dart';
import '../repositories/reset_password_repo.dart';

@injectable
class ResetPasswordUseCase {
  ResetPasswordUseCase(this._resetPasswordRepo);

  final ResetPasswordRepo _resetPasswordRepo;

  Future<ApiResult<void>> invoke(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return _resetPasswordRepo.resetPassword(resetPasswordRequestModel);
  }
}
