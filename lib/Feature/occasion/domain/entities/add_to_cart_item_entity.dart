import 'product_entity.dart';

class AddToCartItemEntity {
  final ProductEntity? product;
  final int? price;
  final int? quantity;
  final String? id;

  AddToCartItemEntity({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}
