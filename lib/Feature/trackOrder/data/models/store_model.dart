import 'package:json_annotation/json_annotation.dart';
import 'location_model.dart';

part 'store_model.g.dart';

@JsonSerializable(explicitToJson: true)
class StoreModel {
  factory StoreModel.fromJson(Map<String, dynamic> json) =>
      _$StoreModelFromJson(json);

  const StoreModel({this.storeLocation});

  @JsonKey(name: 'location')
  final LocationModel? storeLocation;

  Map<String, dynamic> toJson() => _$StoreModelToJson(this);
}
