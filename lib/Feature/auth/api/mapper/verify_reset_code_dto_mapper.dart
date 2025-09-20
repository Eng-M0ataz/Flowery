import '../../domain/entities/response/verify_reset_code_response_entity.dart';
import '../models/response/verify_reset_code_response_dto.dart';

extension VerifyResetCodeDtoMapper on VerifyResetCodeResponseDto {
  VerifyResetCodeResponseEntity toEntity() {
    return VerifyResetCodeResponseEntity(status: status ?? '');
  }
}
