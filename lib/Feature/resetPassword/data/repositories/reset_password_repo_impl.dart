import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/data/dataSources/reset_password_data_source.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/data/dataSources/reset_password_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/entity/reset_password_entity.dart'
    show ResetPasswordEntity;
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/repositories/reset_password_repo.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/Errors/api_results.dart';

@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImpl implements ResetPasswordRepo {
  ResetPasswordRepoImpl(
      this._resetPasswordDataSource, this._resetPasswordLocalDataSource);

  final ResetPasswordRemoteDataSource _resetPasswordDataSource;
  final ResetPasswordLocalDataSource _resetPasswordLocalDataSource;

  @override
  Future<ApiResult<ResetPasswordEntity>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return _resetPasswordDataSource.resetPassword(resetPasswordRequestModel);
  }

  @override
  Future<ApiResult<void>> writeToken({required String token}) async {
    return await _resetPasswordLocalDataSource.WriteToken(token: token);
  }
}
