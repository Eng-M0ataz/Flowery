import 'package:flower_e_commerce_app/Feature/auth/domain/useCases/log_out_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/presentation/viewModels/profileViewModel/profile_main_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/presentation/viewModels/profileViewModel/profile_main_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../domain/entities/response/logged_user_data_response_entity.dart';
import '../../../domain/useCases/get_logged_user_use_case.dart';

@injectable
class ProfileMainViewModel extends Cubit<ProfileMainState> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  final LogOutUseCase _logOutUseCase;

  ProfileMainViewModel(this._getLoggedUserUseCase, this._logOutUseCase)
      : super(ProfileMainState());

  Future<void> doIntend(ProfileMainEvent event) async {
    switch (event) {
      case GetLoggedUserDataEvent():
        await _getLoggedUserData();
      case LogOutEvent():
        logOut();
    }
  }

  Future<void> _getLoggedUserData() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getLoggedUserUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<LoggedUserDataResponseEntity>():
        emit(state.copyWith(
            isLoading: false, loggedUserDataResponseEntity: result.data));
        break;
      case ApiErrorResult<LoggedUserDataResponseEntity>():
        emit(state.copyWith(isLoading: false, failure: result.failure));
        break;
    }
  }

  Future<void> logOut() async {
    final result = await _logOutUseCase.invoke();
    switch (result) {
      case ApiSuccessResult<void>():
        emit(state.copyWith(isLogOutLoading: false));
      case ApiErrorResult<void>():
        emit(state.copyWith(failure: result.failure));
    }
  }
}
