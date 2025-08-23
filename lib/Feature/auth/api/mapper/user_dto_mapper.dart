import 'package:flower_e_commerce_app/Feature/auth/api/models/user_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/response/sign_up_response_entity.dart';

extension UserDtoMapper on UserDto {
  UserEntity toEntity() {
    return UserEntity(
      id: id,
      gender: gender??"",
      photo: photo??"",
      wishlist: wishlist??[],
      addresses: addresses??[],
      firstName: firstName??"",
      lastName: lastName??"",
      email: email,
      phone: phone??"",
      role: role,
      createdAt: createdAt,
    );
  }
}
