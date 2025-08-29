import 'package:json_annotation/json_annotation.dart';
import '../../../domain/entities/request/forget_password_request_entity.dart';

part 'forget_password_request.g.dart';

@JsonSerializable()
class ForgetPasswordRequest {
  @JsonKey(name: 'email')
  final String email;

  ForgetPasswordRequest({
    required this.email,
  });

  factory ForgetPasswordRequest.fromDomain(ForgetPasswordRequestEntity entity) {
    return ForgetPasswordRequest(
      email: entity.email,
    );
  }

  factory ForgetPasswordRequest.fromJson(Map<String, dynamic> json) =>
      _$ForgetPasswordRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ForgetPasswordRequestToJson(this);
}
