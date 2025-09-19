import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/user_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/request/edit_profile_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/edit_profile_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/user_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/edit_profile_response_entity.dart';

extension EditProfileResponseMapper on EditProfileResponseDto {
  EditProfileResponseEntity toEntity() {
    return EditProfileResponseEntity(
      message: message,
      user: user?.toEntity(),
    );
  }
}

extension UserMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}

extension EditProfileRequestMapper on EditProfileRequestEntity {
  EditProfileRequestModel toModel() {
    return EditProfileRequestModel(
      firstName: firstName,
      lastName: lastName,
      email: email,
      phone: phone,
    );
  }
}
