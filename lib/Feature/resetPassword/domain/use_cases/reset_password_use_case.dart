import 'package:flower_e_commerce_app/Feature/resetPassword/domain/entity/reset_password_entity.dart'
    show ResetPasswordEntity;
import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';
import '../../api/model/request/reset_password_request_model.dart';
import '../repositories/reset_password_repo.dart';

@injectable
class ResetPasswordUseCase {
  ResetPasswordUseCase(this._resetPasswordRepo);

  final ResetPasswordRepo _resetPasswordRepo;

  Future<ApiResult<ResetPasswordEntity>> invoke(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return _resetPasswordRepo.resetPassword(resetPasswordRequestModel);
  }
}
