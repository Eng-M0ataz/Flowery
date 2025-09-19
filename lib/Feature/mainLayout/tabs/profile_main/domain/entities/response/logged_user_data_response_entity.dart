import '../logged_user_entity.dart';

class LoggedUserDataResponseEntity {
  final String? message;
  final LoggedUserEntity? user;

  const LoggedUserDataResponseEntity({
    this.message,
    this.user,
  });
}