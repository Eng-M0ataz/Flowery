import 'package:flower_e_commerce_app/Feature/AddressFeature/domain/entities/address_entity.dart';

class AddressResponseEntity {
  final String? message;
  final List<AddressEntity> addresses;

  AddressResponseEntity({
    required this.message,
    required this.addresses,
  });
}
