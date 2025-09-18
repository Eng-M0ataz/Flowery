class ResetPasswordRequestEntity {
  final String email;
  final String newPassword;

  ResetPasswordRequestEntity({
    required this.email,
    required this.newPassword,
  });
}
