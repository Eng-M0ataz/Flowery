import 'package:flower_e_commerce_app/Feature/trackMap/api/models/polyline_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'route_dto.g.dart';

@JsonSerializable(createToJson: false)
class RouteDto {
  final PolylineDto? polyline;

  RouteDto({this.polyline});

  factory RouteDto.fromJson(Map<String, dynamic> json) =>
      _$RouteDtoFromJson(json);
}
