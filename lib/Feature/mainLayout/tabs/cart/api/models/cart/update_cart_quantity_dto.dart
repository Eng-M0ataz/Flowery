import 'package:json_annotation/json_annotation.dart';
part 'update_cart_quantity_dto.g.dart';

@JsonSerializable()
class UpdateCartQuantityInput {
  final int quantity;

  UpdateCartQuantityInput(this.quantity);

  Map<String, dynamic> toJson() => _$UpdateCartQuantityInputToJson(this);
}
