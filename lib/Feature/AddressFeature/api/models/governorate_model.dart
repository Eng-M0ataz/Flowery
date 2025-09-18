import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/governorate_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'governorate_model.g.dart';

@JsonSerializable()
class GovernorateModel extends GovernorateEntity {
  GovernorateModel({
    required int id,
    @JsonKey(name: 'governorate_name_ar') required String governorateNameAr,
    @JsonKey(name: 'governorate_name_en') required String governorateNameEn,
  }) : super(
          id: id,
          governorateNameAr: governorateNameAr,
          governorateNameEn: governorateNameEn,
        );

  factory GovernorateModel.fromJson(Map<String, dynamic> json) {
    return GovernorateModel(
      id: int.parse(json['id'].toString()),
      governorateNameAr: json['governorate_name_ar'].toString(),
      governorateNameEn: json['governorate_name_en'].toString(),
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id.toString(),
        'governorate_name_ar': governorateNameAr,
        'governorate_name_en': governorateNameEn,
      };
}
