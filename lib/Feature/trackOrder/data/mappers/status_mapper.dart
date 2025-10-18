import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/status_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/status_entity.dart';

extension StatusModelMapper on StatusModel {
  StatusEntity toEntity() {
    return StatusEntity(
      status: status ?? '',
      statusUpdateDate: statusUpdateDate ?? '',
    );
  }
}
