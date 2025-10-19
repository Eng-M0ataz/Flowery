import '../../domain/entities/response/address_entity.dart';
import '../models/response/address_dto.dart';

extension AddressDtoMapper on AddressDto {
  AddressEntity toEntity() {
    return AddressEntity(
      street: street??'',
      phone: phone??'',
      city: city??'',
      lat: lat??'',
      long: long??'',
      username: username??'',
      id: id??'',
    );
  }
}
