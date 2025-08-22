import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/forgetPassword/forget_password_states.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';
import '../../../../../core/Errors/api_results.dart';
import '../../../../../core/localization/locale_keys.g.dart';
import '../../../domain/entities/request/forget_password_request_entity.dart';
import '../../../domain/entities/request/reset_password_request_entity.dart';
import '../../../domain/entities/request/verify_reset_code_request_entity.dart';
import '../../../domain/entities/response/forget_password_response_entity.dart';
import '../../../domain/entities/response/reset_password_response_entity.dart';
import '../../../domain/entities/response/verify_reset_code_response_entity.dart';
import '../../../domain/useCases/forget_password_use_case.dart';
import '../../../domain/useCases/reset_password_use_case.dart';
import '../../../domain/useCases/verify_reset_code_use_case.dart';
import 'forget_password_intent.dart';

@injectable
class ForgetPasswordViewModel extends Cubit<ForgetPasswordState> {
  final ForgetPasswordUseCase _forgetPasswordUseCase;
  final VerifyResetCodeUseCase _verifyResetCodeUseCase;
  final ResetPasswordUseCase _resetPasswordUseCase;

  ForgetPasswordViewModel(this._forgetPasswordUseCase,
      this._verifyResetCodeUseCase, this._resetPasswordUseCase)
      : super(const ForgetPasswordState());

  final forgetPasswordKey = GlobalKey<FormState>();
  final verifyCodeKey = GlobalKey<FormState>();
  final resetPasswordKey = GlobalKey<FormState>();
  final PageController pageController = PageController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController codeController = TextEditingController();

  @override
  Future<void> close() {
    emailController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    codeController.dispose();
    return super.close();
  }

  String getSuccessMessage(ForgetPasswordState state) {
    switch (state.step) {
      case ForgetPasswordStep.verify:
        return LocaleKeys.otpSentSuccess.tr();
      case ForgetPasswordStep.resend:
        return LocaleKeys.otpSentSuccess.tr();
      case ForgetPasswordStep.reset:
        if (state.resetResponse != null) {
          return LocaleKeys.passwordResetSuccess.tr();
        } else {
          return LocaleKeys.codeVerifiedSuccess.tr();
        }
      case ForgetPasswordStep.forget:
        return LocaleKeys.operationCompleted.tr();
    }
  }

  void handleSuccessNavigation(BuildContext context, ForgetPasswordState state,
      PageController pageController) {
    switch (state.step) {
      case ForgetPasswordStep.verify:
        pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
        break;
      case ForgetPasswordStep.reset:
        if (state.resetResponse != null) {
          Navigator.of(context).pop();
        } else {
          pageController.nextPage(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOut,
          );
        }
        break;
      case ForgetPasswordStep.resend:
        break;
      case ForgetPasswordStep.forget:
        break;
    }
  }

  Future<void> doIntent(ForgetPasswordIntent intent) async {
    switch (intent) {
      case SendForgetRequestIntent():
        await _sendForgetRequest(emailController.text);
        break;
      case VerifyCodeIntent():
        await _verifyCode(codeController.text);
        break;
      case ResendCodeIntent():
        await _resendCode();
        break;
      case ResetPasswordIntent():
        await _resetPassword(newPasswordController.text);
        break;
      case ResendTimerFinishedIntent():
        await _onResendTimerFinished();
        break;
    }
  }

  Future<void> _onResendTimerFinished() async {
    emit(state.copyWith(isResendAvailable: true));
  }

  Future<void> _sendForgetRequest(String email) async {
    if (!forgetPasswordKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(status: ForgetPasswordStatus.loading));
    final result = await _forgetPasswordUseCase.invoke(
      ForgetPasswordRequestEntity(email: email),
    );

    switch (result) {
      case ApiSuccessResult<ForgetPasswordResponseEntity>():
        emit(state.copyWith(
          step: ForgetPasswordStep.verify,
          status: ForgetPasswordStatus.success,
          email: email,
          forgetResponse: result.data,
          errorMsg: null,
        ));
        break;
      case ApiErrorResult<ForgetPasswordResponseEntity>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.error,
          errorMsg: result.failure.errorMessage,
        ));
        break;
    }
  }

  Future<void> _verifyCode(String code) async {
    if (!verifyCodeKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await _verifyResetCodeUseCase.invoke(
      VerifyResetCodeRequestEntity(resetCode: code),
    );

    switch (result) {
      case ApiSuccessResult<VerifyResetCodeResponseEntity>():
        emit(state.copyWith(
          step: ForgetPasswordStep.reset,
          status: ForgetPasswordStatus.success,
          verifyResponse: result.data,
          errorMsg: null,
        ));
        break;
      case ApiErrorResult<VerifyResetCodeResponseEntity>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.error,
          errorMsg: result.failure.errorMessage,
        ));
        break;
    }
  }

  Future<void> _resendCode() async {
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await _forgetPasswordUseCase.invoke(
      ForgetPasswordRequestEntity(email: state.email!),
    );

    switch (result) {
      case ApiSuccessResult<ForgetPasswordResponseEntity>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.success,
          forgetResponse: result.data,
          errorMsg: null,
          step: ForgetPasswordStep.resend,
          isResendAvailable: false,
        ));
        break;
      case ApiErrorResult<ForgetPasswordResponseEntity>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.error,
          errorMsg: result.failure.errorMessage,
        ));
        break;
    }
  }

  Future<void> _resetPassword(String newPassword) async {
    if (!resetPasswordKey.currentState!.validate()) {
      return;
    }
    emit(state.copyWith(status: ForgetPasswordStatus.loading));

    final result = await _resetPasswordUseCase.invoke(
      ResetPasswordRequestEntity(email: state.email!, newPassword: newPassword),
    );

    switch (result) {
      case ApiSuccessResult<ResetPasswordResponseEntity>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.success,
          resetResponse: result.data,
          errorMsg: null,
        ));
        break;
      case ApiErrorResult<ResetPasswordResponseEntity>():
        emit(state.copyWith(
          status: ForgetPasswordStatus.error,
          errorMsg: result.failure.errorMessage,
        ));
        break;
    }
  }


}
