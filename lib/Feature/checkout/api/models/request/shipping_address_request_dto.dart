import 'package:json_annotation/json_annotation.dart';

part 'shipping_address_request_dto.g.dart';

@JsonSerializable()
class ShippingAddressRequestDto {
  @JsonKey(name: "street")
  final String street;
  @JsonKey(name: "phone")
  final String phone;
  @JsonKey(name: "city")
  final String city;
  @JsonKey(name: "lat")
  final String lat;
  @JsonKey(name: "long")
  final String long;

  ShippingAddressRequestDto({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });

  factory ShippingAddressRequestDto.fromJson(Map<String, dynamic> json) {
    final data = json['shippingAddress'] ?? json;
    return _$ShippingAddressRequestDtoFromJson(Map<String, dynamic>.from(data));
  }

  Map<String, dynamic> toJson() {
    return {
      "shippingAddress": _$ShippingAddressRequestDtoToJson(this),
    };
  }
}
