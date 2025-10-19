class ShippingAddressEntity {
  final String street;
  final String phone;
  final String city;
  final double lat;
  final double long;

  const ShippingAddressEntity({
    required this.street,
    required this.phone,
    required this.city,
    required this.lat,
    required this.long,
  });
}
