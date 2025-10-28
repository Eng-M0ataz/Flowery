class ProductEntity {
  final String? id;
  final String? title;
  final String? description;
  final String? imgCover;
  final num? price;
  final num? priceAfterDiscount;
  final DateTime? createdAt;
  final int? quantity;
  final String? category;
  final int? sold;
  final List<String>? images;

  ProductEntity({
    this.id,
    this.title,
    this.description,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.createdAt,
    this.quantity,
    this.category,
    this.sold,
    this.images,
  });

  int get discountPercent {
    if (price != null && price! > 0) {
      return ((1 - ((priceAfterDiscount ?? price!) / price!)) * 100).round();
    }
    return 0;
  }
}
