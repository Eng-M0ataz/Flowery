import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/address_dto.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/api/models/response/address_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_entity.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_response_entity.dart';

extension AddressDtoMapper on AddressDto {
  AddressEntity toEntity() => AddressEntity(
        id: id ?? "",
        street: street ?? "",
        phone: phone ?? "",
        city: city ?? "",
        lat: lat ?? "",
        long: long ?? "",
        username: username ?? "",
      );
}

extension AddressResponseDtoMapper on AddressResponseDto {
  AddressResponseEntity toEntity() => AddressResponseEntity(
        message: message ?? "",
        addresses: addresses?.map((dto) => dto.toEntity()).toList() ?? [],
      );
}
