import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/add_to_cart_mapper.dart';
import '../../domain/entities/response/add_product_response_entity.dart';
import '../models/response/add_product_response_dto.dart';

extension AddProductResponseMapper on AddProductResponseDto {
  AddProductResponseEntity toEntity() {
    return AddProductResponseEntity(
      message: message ?? '',
      numOfCartItems: numOfCartItems ?? 0,
      cart: cart?.toEntity(),
    );
  }
}
