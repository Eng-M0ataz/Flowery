import 'package:equatable/equatable.dart';
import '../../../domain/entities/response/forget_password_response_entity.dart';
import '../../../domain/entities/response/reset_password_response_entity.dart';
import '../../../domain/entities/response/verify_reset_code_response_entity.dart';

enum ForgetPasswordStep { forget, verify, reset, resend }

enum ForgetPasswordStatus { initial, loading, success, error }

class ForgetPasswordState extends Equatable {
  final ForgetPasswordStep step;
  final ForgetPasswordStatus status;
  final String? errorMsg;
  final bool isResendAvailable;
  final String? email;
  final ForgetPasswordResponseEntity? forgetResponse;
  final VerifyResetCodeResponseEntity? verifyResponse;
  final ResetPasswordResponseEntity? resetResponse;

  const ForgetPasswordState({
    this.step = ForgetPasswordStep.forget,
    this.status = ForgetPasswordStatus.initial,
    this.isResendAvailable = true,
    this.errorMsg,
    this.email,
    this.forgetResponse,
    this.verifyResponse,
    this.resetResponse,
  });

  ForgetPasswordState copyWith({
    ForgetPasswordStep? step,
    ForgetPasswordStatus? status,
    String? errorMsg,
    bool? isResendAvailable,
    String? email,
    ForgetPasswordResponseEntity? forgetResponse,
    VerifyResetCodeResponseEntity? verifyResponse,
    ResetPasswordResponseEntity? resetResponse,
  }) {
    return ForgetPasswordState(
      step: step ?? this.step,
      status: status ?? this.status,
      errorMsg: errorMsg ?? this.errorMsg,
      email: email ?? this.email,
      forgetResponse: forgetResponse ?? this.forgetResponse,
      verifyResponse: verifyResponse ?? this.verifyResponse,
      resetResponse: resetResponse ?? this.resetResponse,
      isResendAvailable: isResendAvailable ?? this.isResendAvailable,
    );
  }

  @override
  List<Object?> get props => [
        step,
        status,
        errorMsg,
        email,
        forgetResponse,
        verifyResponse,
        resetResponse,
        isResendAvailable,
      ];
}
