import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/driver_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/driver_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/location_entity.dart';
import 'location_mapper.dart';

extension DriverModelMapper on DriverModel {
  DriverEntity toEntity() {
    return DriverEntity(
      driverLocation: driverLocation?.toEntity()??LocationEntity(long: 0,lat: 0),
      firstName: firstName??'',
      lastName: lastName??'',
      phone: phone??'',
      driverPhotoUrl: driverPhotoUrl??'',
    );
  }
}
