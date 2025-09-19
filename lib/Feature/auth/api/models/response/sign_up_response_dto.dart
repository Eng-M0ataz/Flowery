import 'package:flower_e_commerce_app/Feature/auth/api/models/user_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'sign_up_response_dto.g.dart';

@JsonSerializable()
class SignUpResponseDto {
  @JsonKey(name: 'message')
  final String? message;
  @JsonKey(name: 'user')
  final UserDto? user;
  @JsonKey(name: 'token')
  final String? token;

  SignUpResponseDto({
    required this.message,
    required this.user,
    required this.token,
  });

  factory SignUpResponseDto.fromJson(Map<String, dynamic> json) =>
      _$SignUpResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignUpResponseDtoToJson(this);
}
