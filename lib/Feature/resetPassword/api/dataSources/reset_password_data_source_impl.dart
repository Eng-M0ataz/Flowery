import 'package:flower_e_commerce_app/Feature/resetPassword/api/client/reset_password_api_service.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/api/model/request/reset_password_request_model.dart';
import 'package:flower_e_commerce_app/Feature/resetPassword/data/dataSources/reset_password_data_source.dart';
import 'package:injectable/injectable.dart';
import '../../../../core/Errors/api_results.dart';
import '../../../../core/Functions/execute_api.dart';


@Injectable(as: ResetPasswordRemoteDataSource)
class ResetPasswordDataSourceImpl implements ResetPasswordRemoteDataSource {
  ResetPasswordDataSourceImpl(this._resetPasswordApiService);

  final ResetPasswordApiService _resetPasswordApiService;

  @override
  Future<ApiResult<void>> resetPassword(
    ResetPasswordRequestModel resetPasswordRequestModel,
  ) {
    return executeApi<void, void>(
      request: () =>
          _resetPasswordApiService.resetPassword(resetPasswordRequestModel),
      mapper: null,
    );
  }
}
