import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/Entity/sign_in_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/use_cases/sign_in_use_case.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';

@injectable
class SigninViewModel extends Cubit<SignInState> {
  final SigninUseCase _useCase;
  SigninViewModel(this._useCase) : super(SignInInitial());

  Future<void> signin({
    required String email,
    required String password
  }) async {
    emit(SignInLoading());
    final result = await _useCase.invoke(
        email: email,
        password: password
    );
    result.when(
        success: (data) => emit(SignInSuccess(ApiSuccessResult(data: data))),
        error: (failure) => emit(SignInError(failure.errorMessage))
    );
  }
}
