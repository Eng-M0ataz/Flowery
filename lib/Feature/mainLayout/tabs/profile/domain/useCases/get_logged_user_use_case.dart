import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
@injectable
class GetLoggedUserUseCase {
  final ProfileRepo _profileRepo;

  GetLoggedUserUseCase(this._profileRepo);

  Future<ApiResult<LoggedUserDataResponseEntity>> invoke() async {
    return await _profileRepo.getLoggedUserData();
  }
}
