
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/metadata_dto.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/domain/entities/metadata_entity.dart';

extension MetadataMapper on MetaDataDto {
  MetadataEntity toEntity() {
    return MetadataEntity(
      currentPage: currentPage,
      limit: limit,
      totalItems: totalItems,
      totalPages: totalPages,
    );
  }
}