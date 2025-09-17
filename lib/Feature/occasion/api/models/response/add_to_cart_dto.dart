import 'package:json_annotation/json_annotation.dart';
import 'add_to_cart_item_dto.dart';

part 'add_to_cart_dto.g.dart';

@JsonSerializable()
class AddToCartDto {
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "cartItems")
  final List<AddToCartItemDto>? cartItems;
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "appliedCoupons")
  final List<dynamic>? appliedCoupons;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "__v")
  final int? v;

  AddToCartDto({
    this.user,
    this.cartItems,
    this.id,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory AddToCartDto.fromJson(Map<String, dynamic> json) =>
      _$AddToCartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AddToCartDtoToJson(this);
}
