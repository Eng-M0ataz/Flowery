import 'dart:io';
import 'package:flower_e_commerce_app/Feature/editProfile/api/client/profile_api_service.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/api/mapper/edit_profile_mapper.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/api/mapper/logged_user_response_mapper.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/api/mapper/upload_photo_mapper.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/api/models/response/edit_profile_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/api/models/response/logged_user_data_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/api/models/response/upload_photo_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/data/dataSources/profile_remote_data_source.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/request/edit_profile_request_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/edit_profile_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/logged_user_data_response_entity.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/upload_photo_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/api_results.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_api.dart';
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
      request: () =>
          _profileApiService.editProfile(editProfileRequestEntity.toModel()),
      mapper: (dto) => dto.toEntity(),
    );
  }

  @override
  Future<ApiResult<LoggedUserDataResponseEntity>> getLoggedUserData() async {
    return executeApi<LoggedUserDataResponseDto, LoggedUserDataResponseEntity>(
        request: () => _profileApiService.getLoggedUserData(),
        mapper: (dto) => dto.toEntity());
  }

  @override
  Future<ApiResult<UploadPhotoResponseEntity>> uploadProfilePhoto(
      File imageFile) async {
    return executeApi<UploadPhotoResponseDto, UploadPhotoResponseEntity>(
      request: () => _profileApiService.uploadProfilePhoto(imageFile),
      mapper: (dto) => dto.toEntity(),
    );
  }
}
