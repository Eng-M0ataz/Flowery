import 'package:json_annotation/json_annotation.dart';
import 'add_to_cart_dto.dart';

part 'add_product_response_dto.g.dart';

@JsonSerializable()
class AddProductResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "numOfCartItems")
  final int? numOfCartItems;
  @JsonKey(name: "cart")
  final AddToCartDto? cart;

  AddProductResponseDto({
    this.message,
    this.numOfCartItems,
    this.cart,
  });

  factory AddProductResponseDto.fromJson(Map<String, dynamic> json) {
    return _$AddProductResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$AddProductResponseDtoToJson(this);
  }
}
