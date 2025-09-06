import 'dart:io';

import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/repositories/profile_repo.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:injectable/injectable.dart';

@injectable
class UploadPhotoUseCase {
  final ProfileRepo _profileRepo;
  UploadPhotoUseCase({required ProfileRepo profileRepo})
      : _profileRepo = profileRepo;

  Future<ApiResult<UploadPhotoResponseEntity>> invoke(File imageFile) {
    return _profileRepo.uploadProfilePhoto(imageFile);
  }
}
