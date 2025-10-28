import 'package:flower_e_commerce_app/Feature/resetPassword/data/dataSources/reset_password_local_data_source.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';
import 'package:flower_e_commerce_app/core/Services/storage_interface.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ResetPasswordLocalDataSource)
class ResetPasswordLocalDataSourceImpl implements ResetPasswordLocalDataSource {
  final Storage _storage;
  ResetPasswordLocalDataSourceImpl(
      @Named(AppConstants.secureStorage) this._storage);
  @override
  Future<ApiResult<void>> WriteToken({required String token}) async {
    try {
      await _storage.write(key: AppConstants.token, value: token);
      return ApiSuccessResult<void>(data: null);
    } catch (e) {
      final Failure failure = Failure(errorMessage: e.toString());
      return ApiErrorResult<void>(failure: failure);
    }
  }
}
