import 'package:json_annotation/json_annotation.dart';

part 'best_seller_dto.g.dart';

@JsonSerializable()
class BestSellerDto {
  @JsonKey(name: "_id")
  final String? Id;
  @JsonKey(name: "title")
  final String? title;
  @JsonKey(name: "slug")
  final String? slug;
  @JsonKey(name: "description")
  final String? description;
  @JsonKey(name: "imgCover")
  final String? imgCover;
  @JsonKey(name: "images")
  final List<String>? images;
  @JsonKey(name: "price")
  final double? price;
  @JsonKey(name: "priceAfterDiscount")
  final double? priceAfterDiscount;
  @JsonKey(name: "discount")
  final double? discount;
  @JsonKey(name: "rateAvg")
  final int? rateAvg;
  @JsonKey(name: "rateCount")
  final int? rateCount;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "category")
  final String? category;
  @JsonKey(name: "occasion")
  final String? occasion;
  @JsonKey(name: "isSuperAdmin")
  final bool? isSuperAdmin;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? V;
  @JsonKey(name: "sold")
  final int? sold;
  @JsonKey(name: "id")
  final String? id;

  BestSellerDto ({
    this.Id,
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
    this.id,
  });

  factory BestSellerDto.fromJson(Map<String, dynamic> json) {
    return _$BestSellerDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$BestSellerDtoToJson(this);
  }
}