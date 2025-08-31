import 'package:flower_e_commerce_app/Feature/occasion/api/models/meta_data_dto.dart';
import 'package:flower_e_commerce_app/Feature/occasion/domain/entities/meta_data_entity.dart';

extension MetadataDtoMapper on MetadataDto {
  MetadataEntity toEntity() {
    return MetadataEntity(
      currentPage: currentPage ?? 1,
      totalPages: totalPages ?? 1,
      limit: limit ?? 0,
      totalItems: totalItems ?? 0,
    );
  }
}