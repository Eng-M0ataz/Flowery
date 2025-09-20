import 'package:json_annotation/json_annotation.dart';

import '../product_dto.dart';

part 'add_to_cart_item_dto.g.dart';

@JsonSerializable()
class AddToCartItemDto {
  @JsonKey(name: "product")
  final ProductDto? product;
  @JsonKey(name: "price")
  final int? price;
  @JsonKey(name: "quantity")
  final int? quantity;
  @JsonKey(name: "_id")
  final String? id;

  AddToCartItemDto({
    this.product,
    this.price,
    this.quantity,
    this.id,
  });

  factory AddToCartItemDto.fromJson(Map<String, dynamic> json) =>
      _$AddToCartItemDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartItemDtoToJson(this);
}
