import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';
import '../entities/response/logged_user_data_response_entity.dart';
import '../repositories/profile_main_repo.dart';

@injectable
class GetLoggedUserUseCase {
  final ProfileMainRepo _profileRepo;

  GetLoggedUserUseCase(this._profileRepo);

  Future<ApiResult<LoggedUserDataResponseEntity>> invoke() async {
    return await _profileRepo.getLoggedUserData();
  }
}
