import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/api/models/cart/cart_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'cart_response_dto.g.dart';

@JsonSerializable()
class CartResponseDto {
  @JsonKey(name: 'message')
  String? message;
  @JsonKey(name: 'numOfCartItems')
  int? numOfCartItems;
  @JsonKey(name: 'cart')
  CartDto? cart;

  CartResponseDto({this.message, this.numOfCartItems, this.cart});

  factory CartResponseDto.fromJson(Map<String, dynamic> json) {
    return _$CartResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() => _$CartResponseDtoToJson(this);
}
