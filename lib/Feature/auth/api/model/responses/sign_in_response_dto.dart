import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/user_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_response_dto.g.dart';

@JsonSerializable()
class SigninResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final UserDto? user;
  @JsonKey(name: "token")
  final String? token;

  SigninResponseDto ({
    this.message,
    this.user,
    this.token,
  });

  factory SigninResponseDto.fromJson(Map<String, dynamic> json) {
    return _$SigninResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$SigninResponseDtoToJson(this);
  }

  SigninResponseEntity toEntity() {
    return SigninResponseEntity(
      message: message,
      user: user?.toEntity(),
      token: token,
    );
  }
}