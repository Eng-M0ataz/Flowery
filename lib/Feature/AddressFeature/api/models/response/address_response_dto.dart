import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/address_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'address_response_dto.g.dart';

@JsonSerializable()
class AddressResponseDto {
  @JsonKey(name: 'message')
  final String? message;

  @JsonKey(name: 'addresses')
  final List<AddressDto>? addresses;

  AddressResponseDto({
    required this.message,
    required this.addresses,
  });

  factory AddressResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AddressResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddressResponseDtoToJson(this);
}