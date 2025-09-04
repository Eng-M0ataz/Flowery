import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/guest_use_case.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/sign_in_use_case.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/events/signin_event.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/states/sign_in_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninViewModel extends Cubit<SignInState> {
  final SigninUseCase _useCase;
  final guestUseCase _guestUseCase;
  SigninViewModel(this._useCase, this._guestUseCase) : super(SignInState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  Future<void> doIntent(SignInEvent intent) async {
    if (intent is IsGuestEvent) {
      await _isGuest();
    }
  }

  Future<void> signin() async {
    emit(state.copyWith(isLoading: true));
    final result = await _useCase.invoke(
        request: SigninRequestEntity(
            email: emailController.text,
            password: passwordController.text
        ),
        rememberMeChecked: rememberMe
    );
    switch (result) {
      case ApiSuccessResult<SigninResponseEntity>():
        emit(state.copyWith(response: result.data, isLoading: false));
      case ApiErrorResult<SigninResponseEntity>():
        emit(state.copyWith(
            failure: Failure(errorMessage: result.failure.errorMessage),
            isLoading: false));
    }
  }

  Future<void> _isGuest() async {
    emit(state.copyWith(isGuestLoading: true));
    final result = await _guestUseCase.isGuest();
    switch (result) {
      case ApiSuccessResult<void>():
        emit(state.copyWith(isGuestLoading: false, isSuccess: true));

      case ApiErrorResult<void>():
        emit(state.copyWith(
            isGuestLoading: false, errorMessage: result.failure.errorMessage));
    }
  }
}
