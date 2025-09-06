import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/user_response_entity.dart';

class SigninResponseEntity {
  final String? message;
  final UserEntity? user;
  final String? token;

  SigninResponseEntity({
    this.message,
    this.user,
    this.token,
  });
}
