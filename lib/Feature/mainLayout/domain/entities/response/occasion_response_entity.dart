import '../meta_data_entity.dart';
import '../occasion_entity.dart';

class OccasionResponseEntity {
  final String message;
  final MetadataEntity metadata;
  final List<OccasionEntity> occasions;

  OccasionResponseEntity({
    required this.message,
    required this.metadata,
    required this.occasions,
  });
}
