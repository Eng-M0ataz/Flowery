import 'dart:convert';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/city_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/governorate_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/data/dataSources/address_local_data_source.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flutter/services.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AddressLocalDataSource)
class AddressLocalDataSourceImpl implements AddressLocalDataSource {
  AddressLocalDataSourceImpl();
  @override
  Future<List<CityEntity>> getCities() async {
    try {
      final String jsonString =
          await rootBundle.loadString(AppConstants.cityJsonFilePath);
      final List<dynamic> jsonData = json.decode(jsonString);

      Map<String, dynamic>? citiesTable;
      for (var item in jsonData) {
        if (item is Map<String, dynamic> &&
            item['type'] == 'table' &&
            item['name'] == 'cities') {
          citiesTable = item;
          break;
        }
      }

      if (citiesTable == null || citiesTable['data'] == null) {
        throw Exception('Cities data not found');
      }

      final List<dynamic> citiesData = citiesTable['data'];
      return citiesData.map((json) => CityModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Failed to load cities: $e');
    }
  }

  @override
  Future<List<GovernorateEntity>> getGovernorates() async {
    try {
      final String jsonString =
          await rootBundle.loadString(AppConstants.governorateJsonFilePath);
      final List<dynamic> jsonData = json.decode(jsonString);

      Map<String, dynamic>? governoratesTable;
      for (var item in jsonData) {
        if (item is Map<String, dynamic> &&
            item['type'] == 'table' &&
            item['name'] == 'governorates') {
          governoratesTable = item;
          break;
        }
      }

      if (governoratesTable == null || governoratesTable['data'] == null) {
        throw Exception('Governorates data not found');
      }

      final List<dynamic> governoratesData = governoratesTable['data'];
      return governoratesData
          .map((json) => GovernorateModel.fromJson(json))
          .toList();
    } catch (e) {
      throw Exception('Failed to load governorates: $e');
    }
  }

  @override
  Future<List<CityEntity>> getCitiesByGovernorateId(int governorateId) async {
    try {
      final List<CityEntity> allCities = await getCities();

      return allCities
          .where((city) => city.governorateId == governorateId)
          .toList();
    } catch (e) {
      throw Exception('Failed to load cities by governorate ID: $e');
    }
  }
}
