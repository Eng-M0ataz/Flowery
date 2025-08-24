import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entity/response/sign_in_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flutter/cupertino.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';

@injectable
class SigninViewModel extends Cubit<SignInState> {
  final SigninUseCase _useCase;
  SigninViewModel(this._useCase) : super(SignInState());

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool rememberMe = false;

  Future<void> signin() async {
    if(formKey.currentState!.validate()){
      emit(state.copyWith(
          isLoading: true
      ));
      final result = await _useCase.invoke(
        request: SigninRequestEntity(
            email: emailController.text,
            password: passwordController.text
        ),
        rememberMeChecked: rememberMe,
      );
      switch(result){
        case ApiSuccessResult<SigninResponseEntity>():
          emit(state.copyWith(
            response: result.data,
            isLoading: false,
          ));
        case ApiErrorResult<SigninResponseEntity>():
          emit(state.copyWith(
              failure: Failure(errorMessage: result.failure.errorMessage),
              isLoading: false
          ));
      }
    }
  }
}
