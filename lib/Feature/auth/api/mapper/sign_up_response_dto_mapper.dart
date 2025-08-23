import 'package:flower_e_commerce_app/Feature/auth/api/mapper/user_dto_mapper.dart';
import 'package:flower_e_commerce_app/Feature/auth/api/models/response/sign_up_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';

extension SignUpResponseDtoMapper on SignUpResponseDto {
  SignUpResponseEntity toEntity() => SignUpResponseEntity(
      message: message ?? "",
      token: token ?? "",
      user: user?.toEntity() ??
          UserEntity(
            addresses: List.empty(),
            email: "",
            firstName: "",
            gender: "",
            id: "",
            lastName: "",
            phone: "",
            photo: "",
            role: "",
            wishlist: List.empty(),
            createdAt: DateTime.now(),
          ));
}
