import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../entities/request/forget_password_request_entity.dart';
import '../entities/response/forget_password_response_entity.dart';


@injectable
class ForgetPasswordUseCase {
  final AuthRepo _authRepo;

  ForgetPasswordUseCase(this._authRepo);

  Future<ApiResult<ForgetPasswordResponseEntity>> invoke(
      ForgetPasswordRequestEntity request) {
    return _authRepo.forgetPassword(request);
  }
}
