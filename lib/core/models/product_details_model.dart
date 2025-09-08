class ProductDetailsModel {
  final String? id;
  final String? title;
  final String? description;
  final int? price;
  final List<String>? images;
  final int? quantity;

  ProductDetailsModel(
      {required this.id,
      required this.price,
      required this.title,
      required this.description,
      required this.images,
      required this.quantity
      });
}
