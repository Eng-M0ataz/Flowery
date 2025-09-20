import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';

class SignUpState {
  final bool isLoading;
  final String? errorMessage;
  final SignUpResponseEntity? response;
  final bool isSuccess;
  final String selectedGender;

  SignUpState(
      {this.isLoading = false,
      this.errorMessage,
      this.response,
      this.isSuccess = false,
      this.selectedGender = 'Female'});

  SignUpState copyWith({
    bool? isLoading,
    String? errorMessage,
    SignUpResponseEntity? response,
    bool? isSuccess,
    String? selectedGender,
  }) {
    return SignUpState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      response: response ?? this.response,
      isSuccess: isSuccess ?? this.isSuccess,
      selectedGender: selectedGender ?? this.selectedGender,
    );
  }
}
