import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/user_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/user_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/location_entity.dart';
import 'location_mapper.dart';

extension UserModelMapper on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      userLocation: userLocation?.toEntity() ?? LocationEntity(long: 0, lat: 0),
    );
  }
}
