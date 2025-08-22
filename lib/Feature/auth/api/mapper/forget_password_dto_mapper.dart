
import '../../domain/entities/response/forget_password_response_entity.dart';
import '../models/response/forget_password_response_dto.dart';

extension ForgetPasswordDtoMapper on ForgetPasswordResponseDto {
  ForgetPasswordResponseEntity toEntity() {
    return ForgetPasswordResponseEntity(
      message: message,
      info: info,
    );
  }
}
