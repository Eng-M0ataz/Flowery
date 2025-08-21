import 'package:flower_e_commerce_app/Feature/auth/domain/entities/requestEntities/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/sign_up_use_case.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/events/sign_up_event.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/states/sign_Up_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignupViewModel extends Cubit<SignUpState> {
  final SignUpUseCase signUpUseCase;

  final TextEditingController signUpFirstNameController =
      TextEditingController();

  final TextEditingController signUpLastNameController =
      TextEditingController();

  final TextEditingController signUpEmailController = TextEditingController();

  final TextEditingController signUpPasswordController =
      TextEditingController();

  final TextEditingController signUpRePasswordController =
      TextEditingController();

  final TextEditingController signUpPhoneController = TextEditingController();

  final formKey = GlobalKey<FormState>();
  String selectedGender = 'Female';
  SignupViewModel(this.signUpUseCase) : super(SignUpState());

  Future<void> doIntent(SignUpEvent event) async {
    switch (event) {
      case SignUpSubmitEvent():
        await _signUp(event);
    }
  }

  Future<void> _signUp(SignUpSubmitEvent event) async {
    emit(state.copyWith(isSuccess: false, isLoading: true, errorMessage: null));

    final signUpRequestEntity = SignUpRequestEntity(
      firstName: event.firstName,
      lastName: event.lastName,
      email: event.email,
      password: event.password,
      rePassword: event.rePassword,
      phone: event.phone,
      gender: event.gender,
    );

    final result = await signUpUseCase.invoke(signUpRequestEntity);
    switch (result) {
      case ApiSuccessResult<SignUpResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: null,
          response: result.data,
          isSuccess: true,
        ));
        break;
      case ApiErrorResult<SignUpResponseEntity>():
        emit(state.copyWith(
          isLoading: false,
          errorMessage: result.failure.errorMessage,
          response: null,
          isSuccess: false,
        ));
        break;
    }
  }

  Future<void> submitSignUpForm() async {
    if (formKey.currentState?.validate() == true) {
      final event = SignUpSubmitEvent(
        firstName: signUpFirstNameController.text.trim(),
        lastName: signUpLastNameController.text.trim(),
        email: signUpEmailController.text.trim(),
        password: signUpPasswordController.text.trim(),
        rePassword: signUpRePasswordController.text.trim(),
        phone: signUpPhoneController.text.trim().startsWith("+")
            ? signUpPhoneController.text.trim()
            : "+2${signUpPhoneController.text.trim()}", // تأكد إنه international
        gender: selectedGender.toLowerCase().trim(), // male / female
      );
      await doIntent(event);
    }
  }

  void updateGender(String gender) {
    selectedGender = gender;
  }

  void clearForm() {
    signUpFirstNameController.clear();
    signUpLastNameController.clear();
    signUpEmailController.clear();
    signUpPasswordController.clear();
    signUpRePasswordController.clear();
    signUpPhoneController.clear();
    selectedGender = 'Female';
  }

  void _disposeControllers() {
    signUpFirstNameController.dispose();
    signUpLastNameController.dispose();
    signUpEmailController.dispose();
    signUpPasswordController.dispose();
    signUpRePasswordController.dispose();
    signUpPhoneController.dispose();
  }

  @override
  Future<void> close() {
    _disposeControllers();
    return super.close();
  }
}
