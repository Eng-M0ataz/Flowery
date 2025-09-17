class SearchProductEntity {
  final String? id;
  final String? title;
  final String? description;
  final String? imgCover;
  final int? price;
  final int? priceAfterDiscount;
  final List<String>? images;
  final int? quantity;
  final int? sold;
  final String? category;
  final String? occasion;

  SearchProductEntity({
    this.id,
    this.title,
    this.description,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.images,
    this.quantity,
    this.sold,
    this.category,
    this.occasion,
  });
}
