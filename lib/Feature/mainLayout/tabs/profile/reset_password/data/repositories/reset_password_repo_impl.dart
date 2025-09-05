import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/data/dataSources/reset_password_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/request/reset_password_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/entities/response/reset_password_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/domain/repositories/reset_password_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';


@Injectable(as: ResetPasswordRepo)
class ResetPasswordRepoImpl implements ResetPasswordRepo{
  final ResetPasswordDataSource _resetPasswordDataSource;

  ResetPasswordRepoImpl({
    required ResetPasswordDataSource resetPasswordDataSource
}):_resetPasswordDataSource=resetPasswordDataSource;

  @override
  Future<ApiResult<ResetPasswordResponseEntity>> resetPassword(ResetPasswordRequestEntity resetPasswordRequestEntity) {
    return _resetPasswordDataSource.resetPassword(resetPasswordRequestEntity);
  }

}