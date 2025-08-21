import 'package:flower_e_commerce_app/Feature/auth/domain/entities/requestEntities/sign_up_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/entities/resposneEntities/sign_up_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class SignUpUseCase {
  final AuthRepo authRepo;
  SignUpUseCase({required this.authRepo});
  Future<ApiResult<SignUpResponseEntity>> invoke(
      SignUpRequestEntity signUpRequestEntity) {
    return authRepo.signUp(signUpRequestEntity);
  }
}
