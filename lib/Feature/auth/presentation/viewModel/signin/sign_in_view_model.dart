import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/Entity/sign_in_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';

@injectable
class SigninViewModel extends Cubit<SignInState> {
  final SigninUseCase _useCase;
  SigninViewModel(this._useCase) : super(SignInState());

  Future<void> signin({
    required String email,
    required String password
  }) async {
    emit(state.copyWith(
      isLoading: true
    ));
    final result = await _useCase.invoke(
        email: email,
        password: password
    );
    switch(result){
      case ApiSuccessResult<SigninResponseEntity>():
        emit(state.copyWith(
            response: result.data,
            isLoading: false
        ));
      case ApiErrorResult<SigninResponseEntity>():
        emit(state.copyWith(
            failure: Failure(errorMessage: result.failure.errorMessage),
            isLoading: false
        ));
    }
  }
}
