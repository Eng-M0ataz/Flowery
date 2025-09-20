import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';

abstract interface class AddressLocalDataSource {
  Future<List<GovernorateEntity>> getGovernorates();
  Future<List<CityEntity>> getCities();
  Future<List<CityEntity>> getCitiesByGovernorateId(int governorateId);
}
