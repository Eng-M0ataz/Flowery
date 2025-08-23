part of 'sign_in_view_model.dart';

 class SignInState {
  final bool isGuestLoading;
  final bool isSuccess;
  final String? errorMessage;

  SignInState({
    this.isGuestLoading = false,
    this.isSuccess=false,
    this.errorMessage,
  });

  SignInState copyWith({
    bool? isGuestLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignInState(
      isGuestLoading: isGuestLoading ?? this.isGuestLoading,
      isSuccess:isSuccess ?? this.isSuccess,
      errorMessage: errorMessage?? this.errorMessage,
    );
  }
}

