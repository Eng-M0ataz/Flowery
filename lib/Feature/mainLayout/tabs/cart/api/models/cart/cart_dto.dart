import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_item_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_dto.g.dart';

@JsonSerializable()
class CartDto {
  @JsonKey(name: '_id')
  String? id;
  @JsonKey(name: 'user')
  String? user;
  @JsonKey(name: 'cartItems')
  List<CartItemDto>? cartItems;
  @JsonKey(name: 'appliedCoupons')
  List<dynamic>? appliedCoupons;
  @JsonKey(name: 'totalPrice')
  double? totalPrice;
  @JsonKey(name: 'createdAt')
  DateTime? createdAt;
  @JsonKey(name: 'updatedAt')
  DateTime? updatedAt;
  @JsonKey(name: '__v')
  int? v;

  CartDto({
    this.id,
    this.user,
    this.cartItems,
    this.appliedCoupons,
    this.totalPrice,
    this.createdAt,
    this.updatedAt,
    this.v,
  });

  factory CartDto.fromJson(Map<String, dynamic> json) =>
      _$CartDtoFromJson(json);

  Map<String, dynamic> toJson() => _$CartDtoToJson(this);
}
