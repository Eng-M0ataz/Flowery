import 'package:equatable/equatable.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class ResetPasswordState extends Equatable{
  final bool isLoading;
  final Failure? failure;
  final bool resetPasswordSuccess;

  const ResetPasswordState({
    this.isLoading = false,
    this.failure,
    this.resetPasswordSuccess = false,
  });

  @override
  List<Object?> get props => [
    isLoading,
    failure,
    resetPasswordSuccess
  ];
  ResetPasswordState copyWith({
    bool? isLoading,
    Failure? failure,
    bool? resetPasswordSuccess,
}){
    return ResetPasswordState(
      isLoading: isLoading?? this.isLoading,
      failure: failure??this.failure,
      resetPasswordSuccess: resetPasswordSuccess??this.resetPasswordSuccess
    );
  }

}