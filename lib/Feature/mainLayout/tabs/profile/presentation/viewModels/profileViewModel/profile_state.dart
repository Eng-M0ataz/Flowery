import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class ProfileState {
  final bool isLoading;
  final Failure? failure;
  final LoggedUserDataResponseEntity? loggedUserDataResponseEntity;

  ProfileState({
    this.isLoading = true,
    this.failure,
    this.loggedUserDataResponseEntity,
  });

  ProfileState copyWith({
    bool? isLoading,
    Failure? failure,
    LoggedUserDataResponseEntity? loggedUserDataResponseEntity,
  }) {
    return ProfileState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      loggedUserDataResponseEntity:
          loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
    );
  }
}
