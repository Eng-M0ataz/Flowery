import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import '../../../api/models/about_app_model.dart';
import '../../../api/models/terms_and_conditions_model.dart';
import '../../../domain/entities/response/logged_user_data_response_entity.dart';

class ProfileMainState {
  final bool isLoading;
  final Failure? failure;
  final LoggedUserDataResponseEntity? loggedUserDataResponseEntity;
  final AboutAppModel? aboutApp;
  final TermsAndConditionsModel? termsAndConditions;
  final Failure? logoutFailure;
  final bool isLogOutLoading;

  ProfileMainState({
    this.isLoading = false,
    this.failure,
    this.loggedUserDataResponseEntity,
    this.aboutApp,
    this.termsAndConditions,
  });
  ProfileMainState(
      {this.isLoading = true,
      this.failure,
      this.loggedUserDataResponseEntity,
      this.isLogOutLoading = true,
      this.logoutFailure});

  ProfileMainState copyWith({
    bool? isLoading,
    Failure? failure,
    LoggedUserDataResponseEntity? loggedUserDataResponseEntity,
    AboutAppModel? aboutApp,
    TermsAndConditionsModel? termsAndConditions,
    final Failure? logoutFailure,
    final bool? isLogOutLoading,
  }) {
    return ProfileMainState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      loggedUserDataResponseEntity:
          loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
      aboutApp: aboutApp ?? this.aboutApp,
      termsAndConditions: termsAndConditions ?? this.termsAndConditions,
        isLogOutLoading: isLogOutLoading ?? this.isLogOutLoading,
        logoutFailure: logoutFailure ?? this.logoutFailure);

    );
  }
}
