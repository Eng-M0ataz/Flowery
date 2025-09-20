import 'add_to_cart_item_entity.dart';

class AddToCartEntity {
  final String? user;
  final List<AddToCartItemEntity>? cartItems;
  final String? id;
  final List<dynamic>? appliedCoupons;
  final int? totalPrice;


  AddToCartEntity({
    this.user,
    this.cartItems,
    this.id,
    this.appliedCoupons,
    this.totalPrice,

  });
}
