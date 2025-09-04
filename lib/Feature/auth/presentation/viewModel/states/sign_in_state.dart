import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
class SignInState {
  SigninResponseEntity? response;
  Failure? failure;
  bool isLoading;
  final bool isGuestLoading;
  final bool isSuccess;
  final String? errorMessage;
  SignInState({
    this.response,
    this.failure,
    this.isLoading = false,
     this.isGuestLoading = false,
    this.isSuccess=false,
    this.errorMessage,
  });

  SignInState copyWith({
    SigninResponseEntity? response,
    Failure? failure,
    bool? isLoading,
        bool? isGuestLoading,
    bool? isSuccess,
    String? errorMessage,
  }) {
    return SignInState(
        response: response ?? this.response,
        failure: failure ?? this.failure,
        isLoading: isLoading ?? this.isLoading,
           isGuestLoading: isGuestLoading ?? this.isGuestLoading,
      isSuccess:isSuccess ?? this.isSuccess,
      errorMessage: errorMessage?? this.errorMessage,
    );
  }
}