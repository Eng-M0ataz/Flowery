
import 'package:flower_e_commerce_app/Feature/auth/domain/Entity/sign_in_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class SigninUseCase{
  AuthRepo authRepo;
  SigninUseCase({
    required this.authRepo
  });

  Future<ApiResult<SigninResponseEntity>> invoke({
    required String email,
    required String password
  }) async {
    final result = await authRepo.signin(
      email: email,
      password: password
    );

    return result.when(
        success: (data) => data as ApiSuccessResult<SigninResponseEntity>,
        error: (failure) => failure as ApiErrorResult<SigninResponseEntity>
    );
  }
}