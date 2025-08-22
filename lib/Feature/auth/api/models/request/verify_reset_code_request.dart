import 'package:json_annotation/json_annotation.dart';

import '../../../domain/entities/request/verify_reset_code_request_entity.dart';


part 'verify_reset_code_request.g.dart';

@JsonSerializable()
class VerifyResetCodeRequest {
  @JsonKey(name: 'resetCode')
  final String resetCode;

  VerifyResetCodeRequest({
    required this.resetCode,
  });

  /// From Domain Entity
  factory VerifyResetCodeRequest.fromDomain(
      VerifyResetCodeRequestEntity entity,
      ) {
    return VerifyResetCodeRequest(
      resetCode: entity.resetCode,
    );
  }

  factory VerifyResetCodeRequest.fromJson(Map<String, dynamic> json) =>
      _$VerifyResetCodeRequestFromJson(json);

  Map<String, dynamic> toJson() => _$VerifyResetCodeRequestToJson(this);
}
