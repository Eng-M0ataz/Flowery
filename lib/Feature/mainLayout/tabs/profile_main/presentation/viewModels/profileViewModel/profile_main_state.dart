import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import '../../../domain/entities/response/logged_user_data_response_entity.dart';

class ProfileMainState {
  final bool isLoading;
  final Failure? failure;
  final LoggedUserDataResponseEntity? loggedUserDataResponseEntity;

  ProfileMainState({
    this.isLoading = true,
    this.failure,
    this.loggedUserDataResponseEntity,
  });

  ProfileMainState copyWith({
    bool? isLoading,
    Failure? failure,
    LoggedUserDataResponseEntity? loggedUserDataResponseEntity,
  }) {
    return ProfileMainState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      loggedUserDataResponseEntity:
          loggedUserDataResponseEntity ?? this.loggedUserDataResponseEntity,
    );
  }
}
