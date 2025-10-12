import 'package:json_annotation/json_annotation.dart';
part 'cart_product_dto.g.dart';

@JsonSerializable()
class CartProductDto {
  @JsonKey(name: 'rateAvg')
  int? rateAvg;
  @JsonKey(name: 'rateCount')
  int? rateCount;
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'title')
  String? title;
  @JsonKey(name: 'slug')
  String? slug;
  @JsonKey(name: 'description')
  String? description;
  @JsonKey(name: 'imgCover')
  String? imgCover;
  @JsonKey(name: 'images')
  List<String>? images;
  @JsonKey(name: 'price')
  double? price;
  @JsonKey(name: 'priceAfterDiscount')
  double? priceAfterDiscount;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: 'category')
  String? category;
  @JsonKey(name: 'occasion')
  String? occasion;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;
  @JsonKey(name: 'isSuperAdmin')
  bool? isSuperAdmin;
  @JsonKey(name: 'sold')
  int? sold;

  CartProductDto({
    this.rateAvg,
    this.rateCount,
    this.id,
    this.title,
    this.slug,
    this.description,
    this.imgCover,
    this.images,
    this.price,
    this.priceAfterDiscount,
    this.quantity,
    this.category,
    this.occasion,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.isSuperAdmin,
    this.sold,
  });

  factory CartProductDto.fromJson(Map<String, dynamic> json) {
    return _$CartProductDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartProductDtoToJson(this);
}
