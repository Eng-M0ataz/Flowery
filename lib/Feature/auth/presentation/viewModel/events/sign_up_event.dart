sealed class SignUpEvent {}

class SignUpSubmitEvent extends SignUpEvent {
  final String firstName;
  final String lastName;
  final String email;
  final String gender;
  final String phone;
  final String password;
  final String rePassword;

  SignUpSubmitEvent({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.gender,
    required this.phone,
    required this.password,
    required this.rePassword,
  });
}
