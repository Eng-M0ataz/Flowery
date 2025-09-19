import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/repositories/profile_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class EditProfileUseCase {
  final ProfileRepo _profileRepo;
  EditProfileUseCase({required ProfileRepo profileRepo})
      : _profileRepo = profileRepo;
  Future<ApiResult<EditProfileResponseEntity>> invoke(
      EditProfileRequestEntity editProfileRequestEntity) {
    return _profileRepo.editProfile(editProfileRequestEntity);
  }
}
