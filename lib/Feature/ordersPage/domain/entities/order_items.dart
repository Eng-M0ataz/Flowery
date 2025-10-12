import '../../../../core/models/product_details_model.dart';

class OrderItemsEntity {
  final ProductDetailsModel? product;
  final int? price;
  final int? quantity;
  final String? id;

  OrderItemsEntity ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}