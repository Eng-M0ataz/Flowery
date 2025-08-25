import 'package:bloc/bloc.dart';

import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/guest_use_case.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/viewModel/viewModel/event/signin_event.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

part 'sign_in_state.dart';

@injectable
class SigninViewModel extends Cubit<SignInState> {
 final GuestUseCase signinUseCase;
  SigninViewModel(this.signinUseCase) : super(SignInState());


 Future<void> doIntent(SignInEvent intent) async {
   if (intent is IsGuestEvent) {
     await _isGuest();
   }
 }

 Future<void>_isGuest() async {
   emit(state.copyWith(isGuestLoading: true));
    final result= await signinUseCase.isGuest();
    switch(result){

      case ApiSuccessResult<void>():
        emit(state.copyWith(isGuestLoading: false,isSuccess: true));

      case ApiErrorResult<void>():
        emit(state.copyWith(isGuestLoading: false, errorMessage: result.failure.errorMessage));

    }


 }
}

