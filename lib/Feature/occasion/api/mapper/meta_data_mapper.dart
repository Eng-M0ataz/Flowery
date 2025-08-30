import '../../domain/entities/meta_data_entity.dart';
import '../models/meta_data_dto.dart';

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