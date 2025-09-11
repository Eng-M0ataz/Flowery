import '../../../../core/models/product_details_model.dart';

class OrderItems {
  final ProductDetailsModel? product;
  final int? price;
  final int? quantity;
  final String? id;

  OrderItems ({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });
}