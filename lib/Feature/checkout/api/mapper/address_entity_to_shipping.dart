import '../../domain/entities/request/shipping_address_entity.dart';
import '../../domain/entities/response/address_entity.dart';

extension AddressEntityToShipping on AddressEntity {
  ShippingAddressEntity toShippingAddress() {
    return ShippingAddressEntity(
      city: city ?? "",
      street: street ?? "",
      phone: phone ?? "",
      lat: double.tryParse(lat ?? "0") ?? 0.0,
      long: double.tryParse(long ?? "0") ?? 0.0,
    );
  }
}
