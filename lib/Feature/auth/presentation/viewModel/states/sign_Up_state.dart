import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';

class SignUpState {
  final bool isLoading;
  final String? errorMessage;
  final SignUpResponseEntity? response;
  final bool isSuccess;
  SignUpState({
    this.isLoading = false,
    this.errorMessage,
    this.response,
    this.isSuccess = false,
  });

  SignUpState copyWith({
    bool? isLoading,
    String? errorMessage,
    SignUpResponseEntity? response,
    bool? isSuccess,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      response: response ?? this.response,
      isSuccess: isSuccess ?? this.isSuccess,
    );
  }
}
