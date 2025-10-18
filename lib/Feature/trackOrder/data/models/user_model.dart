import 'package:json_annotation/json_annotation.dart';
import 'location_model.dart';

part 'user_model.g.dart';

@JsonSerializable(explicitToJson: true)
class UserModel {
  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  const UserModel({this.userLocation});

  @JsonKey(name: 'location')
  final LocationModel? userLocation;

  Map<String, dynamic> toJson() => _$UserModelToJson(this);
}
