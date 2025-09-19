import 'package:flower_e_commerce_app/Feature/auth/api/model/responses/user_response_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'edit_profile_response_dto.g.dart';

@JsonSerializable()
class EditProfileResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'user')
  final UserDto? user;

  EditProfileResponseDto({
    required this.message,
    required this.user,
  });

  factory EditProfileResponseDto.fromJson(Map<String, dynamic> json) =>
      _$EditProfileResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$EditProfileResponseDtoToJson(this);
}
