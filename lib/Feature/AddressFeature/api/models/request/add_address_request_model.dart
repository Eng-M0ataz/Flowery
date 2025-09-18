import 'package:json_annotation/json_annotation.dart';
part 'add_address_request_model.g.dart';

@JsonSerializable()
class AddAddressRequestModel {
  @JsonKey(name: 'street')
  final String street;

  @JsonKey(name: 'phone')
  final String phone;

  @JsonKey(name: 'city')
  final String city;

  @JsonKey(name: 'lat')
  final String lat;

  @JsonKey(name: 'long')
  final String long;

  @JsonKey(name: 'username')
  final String username;

  const AddAddressRequestModel({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  factory AddAddressRequestModel.fromJson(Map<String, dynamic> json) =>
      _$AddAddressRequestModelFromJson(json);

  Map<String, dynamic> toJson() => _$AddAddressRequestModelToJson(this);

}
