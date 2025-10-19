import 'package:flower_e_commerce_app/Feature/occasion/api/mapper/add_to_cart_item_mapper.dart';
import '../../domain/entities/add_to_cart_entity.dart';
import '../models/response/add_to_cart_dto.dart';

extension AddToCartMapper on AddToCartDto {
  AddToCartEntity toEntity() {
    return AddToCartEntity(
      user: user ?? '',
      cartItems: cartItems != null
          ? cartItems!.map((item) => item.toEntity()).toList()
          : [],
      id: id ,
      appliedCoupons: appliedCoupons ?? [],
      totalPrice: totalPrice ?? 0,
    );
  }
}
