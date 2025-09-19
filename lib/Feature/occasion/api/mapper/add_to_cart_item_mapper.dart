import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/product_mapper.dart';
import '../../domain/entities/add_to_cart_item_entity.dart';
import '../models/response/add_to_cart_item_dto.dart';

extension AddToCartItemMapper on AddToCartItemDto {
  AddToCartItemEntity toEntity() {
    return AddToCartItemEntity(
      product: product?.toEntity(),
      price: price ?? 0,
      quantity: quantity ?? 0,
      id: id ?? '',
    );
  }
}
