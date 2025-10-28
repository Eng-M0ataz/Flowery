import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';
import '../repositories/reset_password_repo.dart';

@injectable
class WriteTokenUseCase {
  WriteTokenUseCase(this._resetPasswordRepo);

  final ResetPasswordRepo _resetPasswordRepo;

  Future<ApiResult<void>> invoke({
    required String token,
  }) {
    return _resetPasswordRepo.writeToken(token: token);
  }
}
