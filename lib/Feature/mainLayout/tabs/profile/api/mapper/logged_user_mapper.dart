import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_entity.dart';
import '../models/logged_user_dto.dart';

extension LoggedUserDtoMapper on LoggedUserDto {
  LoggedUserEntity toEntity() {
    return LoggedUserEntity(
      id: id,
      firstName: firstName,
      lastName: lastName,
      email: email,
      gender: gender,
      phone: phone,
      photo: photo,
      wishlist: wishlist,
      addresses: addresses,
    );
  }
}
