
class BestSellerEntity {
  final String? id;
  final String? title;
  final String? slug;
  final String? description;
  final String? imgCover;
  final List<String>? images;
  final double? price;
  double? priceAfterDiscount;
  final double? discount;
  final int? rateAvg;
  final int? rateCount;
  final int? quantity;
  final String? category;
  final String? occasion;
  final bool? isSuperAdmin;
  final String? createdAt;
  final String? updatedAt;
  final int? V;
  final int? sold;

  BestSellerEntity ({
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.discount,
    this.rateAvg,
    this.rateCount,
    this.quantity,
    this.category,
    this.occasion,
    this.isSuperAdmin,
    this.createdAt,
    this.updatedAt,
    this.V,
    this.sold,
  });
}