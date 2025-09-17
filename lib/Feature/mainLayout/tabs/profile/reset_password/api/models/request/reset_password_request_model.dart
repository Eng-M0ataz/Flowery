import 'package:json_annotation/json_annotation.dart';
part 'reset_password_request_model.g.dart';

@JsonSerializable()
class ResetPasswordRequestModel {
  @JsonKey(name: "password")
  final String password;

  @JsonKey(name: "newPassword")
  final String newPassword;

  ResetPasswordRequestModel({
    required this.password,
    required this.newPassword,
  });

  factory ResetPasswordRequestModel.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestModelToJson(this);
}