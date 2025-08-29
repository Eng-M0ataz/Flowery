import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/request/verify_reset_code_request_entity.dart';
import '../entities/response/verify_reset_code_response_entity.dart';
import '../repositories/auth_repo.dart';

@injectable
class VerifyResetCodeUseCase {
  final AuthRepo _authRepo;

  VerifyResetCodeUseCase(this._authRepo);

  Future<ApiResult<VerifyResetCodeResponseEntity>> invoke(
    VerifyResetCodeRequestEntity resetCode,
  ) {
    return _authRepo.verifyResetCode(resetCode);
  }
}
