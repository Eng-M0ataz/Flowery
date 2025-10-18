import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/location_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/location_entity.dart';

extension LocationModelMapper on LocationModel {
  LocationEntity toEntity() {
    return LocationEntity(
      lat: lat ?? 0.0,
      long: long ?? 0.0,
    );
  }
}
