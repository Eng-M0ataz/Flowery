import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/entity/reset_password_entity.dart';

import '../../../../core/Errors/api_results.dart';

abstract interface class ResetPasswordRepo {
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  );
  Future<ApiResult<void>> writeToken({required String token});
}
