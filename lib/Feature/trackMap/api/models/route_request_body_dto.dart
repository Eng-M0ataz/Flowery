import 'package:json_annotation/json_annotation.dart';

part 'route_request_body_dto.g.dart';

@JsonSerializable(explicitToJson: true)
class RouteRequestBodyDto {
  final LocationDto origin;
  final LocationDto destination;
  final String travelMode;
  final String routingPreference;

  RouteRequestBodyDto({
    required this.origin,
    required this.destination,
    this.travelMode = "DRIVE",
    this.routingPreference = "TRAFFIC_AWARE",
  });

  factory RouteRequestBodyDto.fromJson(Map<String, dynamic> json) =>
      _$RouteRequestBodyDtoFromJson(json);
  Map<String, dynamic> toJson() => _$RouteRequestBodyDtoToJson(this);
}

@JsonSerializable(explicitToJson: true)
class LocationDto {
  final LatLngDto location;

  LocationDto({required this.location});

  factory LocationDto.fromJson(Map<String, dynamic> json) =>
      _$LocationDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LocationDtoToJson(this);
}

@JsonSerializable()
class LatLngDto {
  final double latitude;
  final double longitude;

  LatLngDto({required this.latitude, required this.longitude});

  factory LatLngDto.fromJson(Map<String, dynamic> json) =>
      _$LatLngDtoFromJson(json);
  Map<String, dynamic> toJson() => _$LatLngDtoToJson(this);
}
