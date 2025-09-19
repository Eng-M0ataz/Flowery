import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/user_response_entity.dart';

class EditProfileResponseEntity {
  final String? message;
  final UserEntity? user;

  EditProfileResponseEntity({
    required this.message,
    required this.user,
  });
}
