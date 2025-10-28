import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/response/reset_password_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/entity/reset_password_entity.dart';

extension ResetPasswordMapper on ResetPasswordResponseDto {
  ResetPasswordEntity toEntity() {
    return ResetPasswordEntity(token: token ?? '');
  }
}
