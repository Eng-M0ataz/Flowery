import 'package:flower_e_commerce_app/core/Errors/failure.dart';

import '../../../domain/entities/response/logged_user_data_response_entity.dart';

class ProfileMainState {
  final bool isLoading;
  final Failure? failure;
  final LoggedUserDataResponseEntity? loggedUserDataResponseEntity;
  final Failure? logoutFailure;
  final bool isLogOutLoading;

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
    final Failure? logoutFailure,
    final bool? isLogOutLoading,
  }) {
    return ProfileMainState(
        isLoading: isLoading ?? this.isLoading,
        failure: failure ?? this.failure,
        loggedUserDataResponseEntity:
            loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
        isLogOutLoading: isLogOutLoading ?? this.isLogOutLoading,
        logoutFailure: logoutFailure ?? this.logoutFailure);
  }
}
