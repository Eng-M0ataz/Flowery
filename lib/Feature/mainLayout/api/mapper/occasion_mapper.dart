import '../../domain/entities/occasion_entity.dart';
import '../models/occasion_dto.dart';

extension OccasionDtoMapper on OccasionDto {
  OccasionEntity toEntity() {
    return OccasionEntity(
      id: Id ?? '',
      name: name ?? 'Unknown',
      slug: slug ?? '',
      image: image ?? '',
    );
  }
}
