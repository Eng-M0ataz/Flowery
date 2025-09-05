import 'dart:io';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/mapper/edit_profile_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/mapper/logged_user_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/mapper/upload_photo_mapper.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/edit_profile_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/logged_user_data_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/api/models/response/upload_photo_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/data/dataSources/profile_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Errors/execute_api.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ProfileRemoteDataSource)
class ProfileRemoteDataSourceImpl implements ProfileRemoteDataSource {
  final ProfileApiService _profileApiService;
  ProfileRemoteDataSourceImpl({
    required ProfileApiService profileApiService,
  }) : _profileApiService = profileApiService;

  @override
  Future<ApiResult<EditProfileResponseEntity>> editProfile(
      EditProfileRequestEntity editProfileRequestEntity) async {
    return executeApi<EditProfileResponseDto, EditProfileResponseEntity>(
      () => _profileApiService.editProfile(editProfileRequestEntity.toModel()),
      (dto) => dto.toEntity(),
    );
  }


  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() async {
    return executeApi<LoggedUserDataResponseDto, LoggedUserDataResponseEntity>(

        () => _profileApiService.getLoggedUserData(), (dto) => dto.toEntity());
  }

  @override
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
      File imageFile) async {
    return executeApi<UploadPhotoResponseDto, UploadPhotoResponseEntity>(
      () => _profileApiService.uploadProfilePhoto(imageFile),
      (dto) => dto.toEntity(),
    );

  }
}
