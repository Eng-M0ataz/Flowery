class CartEntity {
  List<CartProductEntity> products;
  double totalPrice;
  int numberOfCartItems;

  CartEntity({
    required this.products,
    required this.totalPrice,
    required this.numberOfCartItems,
  });
}

class CartProductEntity {
  String? productId;
  String? productName;
  String? productImage;
  double? productPrice;
  double? priceAfterDiscount;
  int? quantity;

  CartProductEntity({
    this.productId,
    this.productName,
    this.productImage,
    this.productPrice,
    this.priceAfterDiscount,
    this.quantity,
  });
}
