import 'package:flower_e_commerce_app/Feature/auth/domain/Entity/sign_in_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class AuthRepo {
  Future<ApiResult<SigninResponseEntity>> signin({
    required String email,
    required String password
  });
}
