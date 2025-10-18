import 'package:json_annotation/json_annotation.dart';
import 'location_model.dart';

part 'driver_model.g.dart';

@JsonSerializable(explicitToJson: true)
class DriverModel {
  factory DriverModel.fromJson(Map<String, dynamic> json) =>
      _$DriverModelFromJson(json);

  const DriverModel({
    this.driverLocation,
    this.firstName,
    this.lastName,
    this.phone,
    this.driverPhotoUrl,
  });

  @JsonKey(name: 'location')
  final LocationModel? driverLocation;
  @JsonKey(name: 'firstName')
  final String? firstName;
  @JsonKey(name: 'lastName')
  final String? lastName;
  @JsonKey(name: 'phone')
  final String? phone;
  @JsonKey(name: 'photo')
  final String? driverPhotoUrl;

  Map<String, dynamic> toJson() => _$DriverModelToJson(this);
}
