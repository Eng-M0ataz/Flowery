import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/api/models/metadata_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/metadata_entity.dart';

extension MetadataDtoMapper on MetadataDto {
  MetadataEntity toEntity() => MetadataEntity(
        currentPage: currentPage ?? 0,
        limit: limit ?? 0,
        totalPages: totalPages ?? 0,
        totalItems: totalItems ?? 0,
      );
}
