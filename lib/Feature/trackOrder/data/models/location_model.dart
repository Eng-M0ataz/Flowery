import 'package:json_annotation/json_annotation.dart';

part 'location_model.g.dart';

@JsonSerializable(explicitToJson: true)
class LocationModel {
  const LocationModel({this.lat, this.long});

  factory LocationModel.fromJson(Map<String, dynamic> json) =>
      _$LocationModelFromJson(json);

  @JsonKey(name: 'lat')
  final double? lat;
  @JsonKey(name: 'long')
  final double? long;

  Map<String, dynamic> toJson() => _$LocationModelToJson(this);
}
