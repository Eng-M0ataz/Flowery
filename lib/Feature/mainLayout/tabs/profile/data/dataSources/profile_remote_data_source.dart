
import 'dart:io';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class ProfileRemoteDataSource {
  Future<ApiResult<EditProfileResponseEntity>> editProfile(
      EditProfileRequestEntity editProfileRequestEntity);

  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData();
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
      File imageFile);
}

