import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/data/dataSources/reset_password_data_source.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/domain/repositories/reset_password_repo.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';


@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImpl implements ResetPasswordRepo {
  ResetPasswordRepoImpl(this._resetPasswordDataSource);

  final ResetPasswordRemoteDataSource _resetPasswordDataSource;

  @override
  Future<ApiResult<void>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return _resetPasswordDataSource.resetPassword(resetPasswordRequestModel);
  }
}
