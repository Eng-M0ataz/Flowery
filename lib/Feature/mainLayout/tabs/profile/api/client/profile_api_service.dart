import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/request/edit_profile_request_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/edit_profile_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/logged_user_data_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/upload_photo_response_dto.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/api_constants.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/error_logger.dart';
import 'package:retrofit/http.dart';

part 'profile_api_service.g.dart';

@injectable
@RestApi()
abstract class ProfileApiService {
  @factoryMethod
  factory ProfileApiService(Dio dio) = _ProfileApiService;

  @GET(ApiConstants.getLoggedUserData)
  Future<LoggedUserDataResponseDto> getLoggedUserData();

  @PUT(ApiConstants.editProfile)
  Future<EditProfileResponseDto> editProfile(
      @Body() EditProfileRequestModel editProfileRequest);

  @PUT(ApiConstants.uploadPhoto)
  @MultiPart()
  Future<UploadPhotoResponseDto> uploadProfilePhoto(
    @Part(name: "photo") File photo,
  );
}
