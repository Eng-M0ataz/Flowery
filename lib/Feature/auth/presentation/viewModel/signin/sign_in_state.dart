part of 'sign_in_view_model.dart';

abstract class SignInState {}

class SignInInitial extends SignInState {}
class SignInLoading extends SignInState {}
class SignInSuccess extends SignInState {
  final ApiSuccessResult<SigninResponseEntity> response;
  SignInSuccess(this.response);
}
class SignInError extends SignInState {
  final String message;
  SignInError(this.message);
}