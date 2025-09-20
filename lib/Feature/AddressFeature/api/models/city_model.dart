import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/city_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'city_model.g.dart';

@JsonSerializable()
class CityModel extends CityEntity {
  CityModel({
    required int id,
    @JsonKey(name: 'governorate_id') required int governorateId,
    @JsonKey(name: 'city_name_ar') required String cityNameAr,
    @JsonKey(name: 'city_name_en') required String cityNameEn,
  }) : super(
          id: id,
          governorateId: governorateId,
          cityNameAr: cityNameAr,
          cityNameEn: cityNameEn,
        );

  factory CityModel.fromJson(Map<String, dynamic> json) {
    return CityModel(
      id: int.parse(json['id'].toString()),
      governorateId: int.parse(json['governorate_id'].toString()),
      cityNameAr: json['city_name_ar'].toString(),
      cityNameEn: json['city_name_en'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'governorate_id': governorateId.toString(),
        'city_name_ar': cityNameAr,
        'city_name_en': cityNameEn,
      };
}
