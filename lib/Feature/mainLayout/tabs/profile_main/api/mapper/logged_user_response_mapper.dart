import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/api/mapper/logged_user_mapper.dart';
import '../../domain/entities/response/logged_user_data_response_entity.dart';
import '../models/response/logged_user_data_response_dto.dart';

extension LoggedUserDataResponseDtoMapper on LoggedUserDataResponseDto {
  LoggedUserDataResponseEntity toEntity() {
    return LoggedUserDataResponseEntity(
      message: message ?? '',
      user: user?.toEntity(),
    );
  }
}
