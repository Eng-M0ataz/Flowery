import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/request/reset_password_request_model.dart';

import '../../../../core/Errors/api_results.dart';

abstract interface class ResetPasswordRepo {
  Future<ApiResult<void>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  );
}
