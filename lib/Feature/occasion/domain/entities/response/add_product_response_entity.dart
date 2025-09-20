import '../add_to_cart_entity.dart';

class AddProductResponseEntity {
  final String message;
  final int numOfCartItems;
  final AddToCartEntity? cart;

  AddProductResponseEntity({
    required this.message,
    required this.numOfCartItems,
    this.cart,
  });
}
