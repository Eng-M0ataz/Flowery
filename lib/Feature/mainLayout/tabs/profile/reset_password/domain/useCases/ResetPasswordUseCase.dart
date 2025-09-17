import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/repositories/reset_password_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class ResetPasswordUseCase {
  final ResetPasswordRepo _resetPasswordRepo;

  ResetPasswordUseCase({required ResetPasswordRepo resetPasswordRepo})
      : _resetPasswordRepo = resetPasswordRepo;

  Future<ApiResult<ResetPasswordResponseEntity>> invoke(
      ResetPasswordRequestEntity resetPasswordRequestEntity) {
    return _resetPasswordRepo.resetPassword(resetPasswordRequestEntity);
  }
}