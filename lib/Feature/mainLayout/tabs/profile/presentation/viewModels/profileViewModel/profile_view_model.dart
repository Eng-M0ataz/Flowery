import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/useCases/get_logged_user_use_case.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProfileViewModel extends Cubit<ProfileState> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;

  ProfileViewModel(this._getLoggedUserUseCase) : super(ProfileState());

  Future<void> doIntend(ProfileEvent event) async {
    switch (event) {
      case GetLoggedUserDataEvent():
        await _getLoggedUserData();
    }
  }

  Future<void> _getLoggedUserData() async {
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
}
