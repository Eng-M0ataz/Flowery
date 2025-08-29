import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/request/reset_password_request_entity.dart';

part 'reset_password_request.g.dart';

@JsonSerializable()
class ResetPasswordRequest {
  @JsonKey(name: 'email')
  final String email;

  @JsonKey(name: 'newPassword')
  final String newPassword;

  ResetPasswordRequest({
    required this.email,
    required this.newPassword,
  });

  factory ResetPasswordRequest.fromDomain(ResetPasswordRequestEntity entity) {
    return ResetPasswordRequest(
      email: entity.email,
      newPassword: entity.newPassword,
    );
  }

  factory ResetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ResetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ResetPasswordRequestToJson(this);
}
