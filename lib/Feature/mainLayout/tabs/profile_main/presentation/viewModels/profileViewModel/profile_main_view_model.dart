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

  ProfileMainViewModel(this._getLoggedUserUseCase) : super(ProfileMainState());

  Future<void> doIntend(ProfileMainEvent event) async {
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
