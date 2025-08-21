import 'package:flower_e_commerce_app/Feature/auth/api/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response_dto.g.dart';

@JsonSerializable()
class SignUpResponseDto {
  final String message;
  final UserDto user;
  final String token;

  SignUpResponseDto({
    required this.message,
    required this.user,
    required this.token,
  });

  factory SignUpResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignInResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInResponseDtoToJson(this);
}
