import 'package:bloc/bloc.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/entity/reset_password_entity.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/use_cases/write_token_use_case.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/presentation/veiwModel/reset_password_event.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/presentation/veiwModel/reset_password_stats.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';
import '../../domain/use_cases/reset_password_use_case.dart';

@injectable
class ResetPasswordViewModel extends Cubit<ResetPasswordState> {
  ResetPasswordViewModel(this._resetPasswordUseCase, this._writeTokenUseCase)
      : super(const ResetPasswordState());
  final ResetPasswordUseCase _resetPasswordUseCase;
  final WriteTokenUseCase _writeTokenUseCase;

  Future<void> doIntent({
    required ResetPasswordEvents event,
    required ResetPasswordRequestModel resetPasswordRequestModel,
  }) async {
    switch (event) {
      case ResetPasswordEvent():
        await resetPasswordFlow(
          resetPasswordRequestModel: resetPasswordRequestModel,
        );
    }
  }

  Future<void> _resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) async {
    emit(state.copyWith(
      isLoading: true,
    ));

    final result = await _resetPasswordUseCase.invoke(
      resetPasswordRequestModel,
    );

    switch (result) {
      case ApiSuccessResult<ResetPasswordEntity>():
        emit(state.copyWith(
          isLoading: false,
          resetPasswordSuccess: true,
          resetPasswordEntity: result.data,
        ));

      case ApiErrorResult<ResetPasswordEntity>():
        emit(
          state.copyWith(
            isLoading: false,
            failure: result.failure,
            resetPasswordSuccess: false,
          ),
        );
    }
  }

  Future<void> writeToken({required String token}) async {
    final result = await _writeTokenUseCase.invoke(token: token);
    switch (result) {
      case ApiSuccessResult<void>():
        return;
      case ApiErrorResult<void>():
        emit(state.copyWith(storgeFailure: result.failure));
    }
  }

  Future<void> resetPasswordFlow({
    required ResetPasswordRequestModel resetPasswordRequestModel,
  }) async {
    await _resetPassword(resetPasswordRequestModel);
    await writeToken(token: state.resetPasswordEntity!.token);
  }
}
