import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/entity/reset_password_entity.dart';

import '../../../../core/Errors/failure.dart';

class ResetPasswordState extends Equatable {
  const ResetPasswordState({
    this.isLoading = false,
    this.failure,
    this.resetPasswordSuccess = false,
    this.resetPasswordEntity,
    this.storgeFailure,
  });
  final bool isLoading;
  final Failure? failure;
  final Failure? storgeFailure;
  final bool resetPasswordSuccess;
  final ResetPasswordEntity? resetPasswordEntity;

  ResetPasswordState copyWith({
    bool? isLoading,
    Failure? failure,
    bool? resetPasswordSuccess,
    ResetPasswordEntity? resetPasswordEntity,
    Failure? storgeFailure,
  }) {
    return ResetPasswordState(
      isLoading: isLoading ?? this.isLoading,
      failure: failure ?? this.failure,
      resetPasswordSuccess: resetPasswordSuccess ?? this.resetPasswordSuccess,
      resetPasswordEntity: resetPasswordEntity ?? this.resetPasswordEntity,
      storgeFailure: storgeFailure ?? this.storgeFailure,
    );
  }

  @override
  List<Object?> get props => [
        isLoading,
        failure,
        resetPasswordSuccess,
        resetPasswordEntity,
        storgeFailure
      ];
}
