import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request_dto.g.dart';

@JsonSerializable()
class SigninRequestDto {
  @JsonKey(name: "email")
  final String? email;
  @JsonKey(name: "password")
  final String? password;

  SigninRequestDto ({
    this.email,
    this.password,
  });

  factory SigninRequestDto.fromJson(Map<String, dynamic> json) {
    return _$SigninRequestDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SigninRequestDtoToJson(this);
  }
}


