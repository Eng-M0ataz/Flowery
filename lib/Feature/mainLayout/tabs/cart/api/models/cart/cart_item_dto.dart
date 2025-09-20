import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_product_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_item_dto.g.dart';

@JsonSerializable()
class CartItemDto {
  @JsonKey(name: 'product')
  CartProductDto? product;
  @JsonKey(name: 'price')
  int? price;
  @JsonKey(name: 'quantity')
  int? quantity;
  @JsonKey(name: '_id')
  String? id;

  CartItemDto({this.product, this.price, this.quantity, this.id});

  factory CartItemDto.fromJson(Map<String, dynamic> json) {
    return _$CartItemDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartItemDtoToJson(this);
}
