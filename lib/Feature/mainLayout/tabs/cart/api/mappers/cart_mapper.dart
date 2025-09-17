import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_item_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_response_dto.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/domain/entity/cart_entity.dart';

extension CartMapper on CartResponseDto {
  CartEntity toEntity() {
    return CartEntity(
      products:
          cart?.cartItems?.map((cartitem) => cartitem.toEntity()).toList() ??
          [],

      totalPrice: cart?.totalPrice ?? 0,
      numberOfCartItems: numOfCartItems ?? 0,
    );
  }
}

extension CartItemDtoMapper on CartItemDto {
  CartProductEntity toEntity() {
    return CartProductEntity(
      productId: product?.id ?? '',
      priceAfterDiscount: product?.priceAfterDiscount ?? 0,
      productImage: product?.imgCover ?? '',
      productName: product?.title ?? 'No Title Found',
      productPrice: product?.price ?? 0,
      quantity: quantity ?? 0,
    );
  }
}
