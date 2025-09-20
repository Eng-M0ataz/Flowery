import 'package:flower_e_commerce_app/Feature/editProfile/api/models/response/upload_photo_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/domain/entities/response/upload_photo_response_entity.dart';

extension UploadPhotoMapper on UploadPhotoResponseDto {
  UploadPhotoResponseEntity toEntity() {
    return UploadPhotoResponseEntity(
      message: message,
    );
  }
}
