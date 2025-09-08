class BestSellerEntity {
  final String? Id;
  final String? title;
  final String? description;
  final String? imgCover;
  final int? price;
  final int? priceAfterDiscount;
  final List<String>? images;
  final int? quantity;
  int get discountPercent {
    if (price == null || priceAfterDiscount == null || price == 0) return 0;
    return ((price! - priceAfterDiscount!) / price! * 100).round();
  }

  BestSellerEntity ({
    this.Id,
    this.title,
    this.description,
    this.imgCover,
    this.price,
    this.priceAfterDiscount,
    this.images,
    this.quantity

  });
}