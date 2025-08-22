

import '../../domain/entities/response/reset_password_response_entity.dart';
import '../models/response/reset_password_response_dto.dart';

extension ResetPasswordDtoMapper on ResetPasswordResponseDto {
  ResetPasswordResponseEntity toEntity() {
    return ResetPasswordResponseEntity(message: message, token: token);
  }
}
