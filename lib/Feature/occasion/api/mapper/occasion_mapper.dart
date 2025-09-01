import '../../../../core/Functions/image_fixer.dart';
import '../../domain/entities/occasion_entity.dart';
import '../models/occasion_dto.dart';

extension OccasionDtoMapper on OccasionDto {
  OccasionEntity toEntity() {
    return OccasionEntity(
      id: id ?? '',
      name: name ?? 'Unknown',
      slug: slug ?? '',
      image: imageFixer(image),
    );
  }
}
