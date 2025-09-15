class ProductDetailsModel {
  final String? id;
  final String? title;
  final String? description;
  final int? price;
  final double? priceAfterDiscount;
  final String? imageCover;
  final List<String>? images;
  final int? quantity;

  ProductDetailsModel({
    required this.id,
    required this.price,
    required this.title,
    required this.description,
    this.priceAfterDiscount,
    this.imageCover,
    required this.images,
    required this.quantity
  });
}
