import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/logged_user_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'logged_user_data_response_dto.g.dart';

@JsonSerializable()
class LoggedUserDataResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "user")
  final LoggedUserDto? user;

  LoggedUserDataResponseDto({
    this.message,
    this.user,
  });

  factory LoggedUserDataResponseDto.fromJson(Map<String, dynamic> json) {
    return _$LoggedUserDataResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$LoggedUserDataResponseDtoToJson(this);
  }
}
