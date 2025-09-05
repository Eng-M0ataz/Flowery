import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class ResetPasswordDataSource{
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(
      ResetPasswordRequestEntity resetPasswordRequestEntity
      );
}