part of 'sign_in_view_model.dart';

class SignInState {
  SigninResponseEntity? response;
  Failure? failure;
  bool isLoading;

  SignInState({this.response, this.failure, this.isLoading = false});

  SignInState copyWith({
    SigninResponseEntity? response,
    Failure? failure,
    bool? isLoading,
  }) {
    return SignInState(
        response: response ?? this.response,
        failure: failure ?? this.failure,
        isLoading: isLoading ?? this.isLoading);
  }
}
