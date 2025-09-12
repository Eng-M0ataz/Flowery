import 'package:flower_e_commerce_app/Feature/checkout/domain/entities/response/address_entity.dart';

class UserAddressResponseEntity {
  final String? message;
  final List<AddressEntity>? addresses;

  UserAddressResponseEntity(this.message, this.addresses);
}
