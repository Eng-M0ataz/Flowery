import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class ResetPasswordLocalDataSource {
  Future<ApiResult<void>> WriteToken({required String token});
}
