class ResetPasswordRequestEntity{
  final String currantPassword;
  final String newPassword;

  const ResetPasswordRequestEntity({
    required this.currantPassword,
    required this.newPassword
});

}