import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/logged_user_entity.dart';

class LoggedUserDataResponseEntity {
  final String? message;
  final LoggedUserEntity? user;

  const LoggedUserDataResponseEntity({
    this.message,
    this.user,
  });
}
