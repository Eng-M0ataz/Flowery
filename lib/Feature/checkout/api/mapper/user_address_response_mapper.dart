import 'package:flower_e_commerce_app/Feature/checkout/api/mapper/address_mapper.dart';
import '../../domain/entities/response/user_address_response_entity.dart';
import '../models/response/user_address_dto.dart';
extension UserAddressDtoMapper on UserAddressDto {
  UserAddressResponseEntity toEntity() {
    return UserAddressResponseEntity(
      message ?? 'No message',
      addresses?.map((e) => e.toEntity()).toList() ?? [],
    );
  }
}
