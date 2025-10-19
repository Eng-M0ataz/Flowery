import 'package:flower_e_commerce_app/Feature/checkout/api/models/response/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_address_dto.g.dart';

@JsonSerializable()
class UserAddressDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "addresses")
  final List<AddressDto>? addresses;

  UserAddressDto ({
    this.message,
    this.addresses,
  });

  factory UserAddressDto.fromJson(Map<String, dynamic> json) {
    return _$UserAddressDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$UserAddressDtoToJson(this);
  }
}



