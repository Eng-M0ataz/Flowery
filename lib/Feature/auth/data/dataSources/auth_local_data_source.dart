import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class AuthLocalDataSource {
  Future<ApiResult<void>> writeToken({required String token});
  Future<ApiResult<void>> setRememberMe({required bool rememberMe});
  Future<bool> getRememberMe();
  Future<ApiResult<void>> logOut();
}
