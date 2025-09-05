import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/api/models/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/api/models/response/reset_password_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/response/reset_password_response_entity.dart';

extension ResetPasswordMapper on ResetPasswordResponseDto {
  ResetPasswordResponseEntity toEntity() {
    return ResetPasswordResponseEntity(token: token, message: message);
  }
}

extension ResetPasswordRequestMapper on ResetPasswordRequestEntity {
  ResetPasswordRequestModel toModel() {
    return ResetPasswordRequestModel(
        password: currantPassword, newPassword: newPassword);
  }
}
