import 'package:flower_e_commerce_app/Feature/auth/api/model/requests/sign_in_request_dto.dart';

class SigninRequestEntity {
  final String email;
  final String password;

  SigninRequestEntity ({
    required this.email,
    required this.password,
  });

  SigninRequestDto toDto(){
    return SigninRequestDto(
      email: email,
      password: password
    );
  }
}


