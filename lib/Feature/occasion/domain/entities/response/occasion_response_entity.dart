import '../meta_data_entity.dart';
import '../occasion_entity.dart';

class OccasionResponseEntity {
  final String? message;
  final MetadataEntity? metadata;
  final List<OccasionEntity>? occasions;

  OccasionResponseEntity({
    this.message,
    this.metadata,
    this.occasions,
  });
}