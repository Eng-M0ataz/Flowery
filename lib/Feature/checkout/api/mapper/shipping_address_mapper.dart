import '../../domain/entities/request/shipping_address_entity.dart';
import '../models/request/shipping_address_request_dto.dart';

extension ShippingAddressMapper on ShippingAddressEntity {
  ShippingAddressRequestDto toDto() {
    return ShippingAddressRequestDto(
      street: street,
      phone: phone,
      city: city,
      lat: lat.toString(),
      long: long.toString(),
    );
  }
}
