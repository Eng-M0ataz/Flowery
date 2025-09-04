import 'package:flower_e_commerce_app/Feature/auth/domain/entity/request/sign_in_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/auth/domain/repositories/auth_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../entity/response/sign_in_response_entity.dart';

@injectable
class SigninUseCase{
  AuthRepo authRepo;
  SigninUseCase({
    required this.authRepo
  });

  Future<ApiResult<SigninResponseEntity>> invoke({
    required SigninRequestEntity request,
    bool? rememberMeChecked = false
  }) async {


    return await authRepo.signin(
        request: request,
        rememberMeChecked: rememberMeChecked,
    );
  }
}