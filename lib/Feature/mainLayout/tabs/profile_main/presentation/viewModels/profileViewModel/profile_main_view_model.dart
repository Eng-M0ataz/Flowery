import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/presentation/viewModels/profileViewModel/profile_main_event.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/presentation/viewModels/profileViewModel/profile_main_state.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/response/logged_user_data_response_entity.dart';
import '../../../domain/useCases/get_about_app_usecase.dart';
import '../../../domain/useCases/get_logged_user_use_case.dart';
import '../../../domain/useCases/get_terms_and_conditions_usecase.dart';

@injectable
class ProfileMainViewModel extends Cubit<ProfileMainState> {
  final GetLoggedUserUseCase _getLoggedUserUseCase;
  final GetAboutAppUseCase _getAboutAppUseCase;
  final GetTermsAndConditionsUseCase _getTermsUseCase;

  ProfileMainViewModel(this._getLoggedUserUseCase, this._getAboutAppUseCase,
      this._getTermsUseCase)
      : super(ProfileMainState());

  Future<void> doIntend(ProfileMainEvent event) async {
    switch (event) {
      case GetLoggedUserDataEvent():
        await _getLoggedUserData();
        break;

      case GetAboutAppEvent():
        _GetAboutApp();
        break;
      case GetTermsAndConditionsEvent():
        _GetTermsAndConditions();
        break;
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

  Future<void> _GetAboutApp() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getAboutAppUseCase.invoke();
    emit(state.copyWith(isLoading: false, aboutApp: result));
  }

  Future<void> _GetTermsAndConditions() async {
    emit(state.copyWith(isLoading: true));
    final result = await _getTermsUseCase.invoke();
    emit(state.copyWith(isLoading: false, termsAndConditions: result));
  }
}
