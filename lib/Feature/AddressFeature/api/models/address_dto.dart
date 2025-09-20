import 'package:json_annotation/json_annotation.dart';
part 'address_dto.g.dart';

@JsonSerializable()
class AddressDto {
  @JsonKey(name: '_id')
  final String? id;

  @JsonKey(name: 'street')
  final String? street;

  @JsonKey(name: 'phone')
  final String? phone;

  @JsonKey(name: 'city')
  final String? city;

  @JsonKey(name: 'lat')
  final String? lat;

  @JsonKey(name: 'long')
  final String? long;

  @JsonKey(name: 'username')
  final String? username;

  AddressDto({
    required this.id,
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
    required this.username,
  });

  factory AddressDto.fromJson(Map<String, dynamic> json) =>
      _$AddressDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressDtoToJson(this);

  
}