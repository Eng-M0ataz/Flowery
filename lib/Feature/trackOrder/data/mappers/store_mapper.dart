import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/store_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/store_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/location_entity.dart';
import 'location_mapper.dart';

extension StoreModelMapper on StoreModel {
  StoreEntity toEntity() {
    return StoreEntity(
      storeLocation:
          storeLocation?.toEntity() ?? LocationEntity(long: 0, lat: 0),
    );
  }
}
