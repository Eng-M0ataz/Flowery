class ProductEntity {
  final String? id;
  final String? title;
  final String? description;
  final String? imgCover;
  final num? price;
  final num? priceAfterDiscount;
  final int? quantity;
  final String? category;
  final int? sold;
  ProductEntity({
    this.id,
    this.title,
    this.description,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.sold,
  });
}
