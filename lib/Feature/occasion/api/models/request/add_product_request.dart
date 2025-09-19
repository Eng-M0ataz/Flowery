import 'package:json_annotation/json_annotation.dart';

part 'add_product_request.g.dart';

@JsonSerializable()
class AddProductRequest {
  @JsonKey(name: "product")
  final String productId;

  @JsonKey(name: "quantity")
  final int quantity;

  AddProductRequest({
    required this.productId,
  }) : quantity = 1;

  factory AddProductRequest.fromJson(Map<String, dynamic> json) =>
      _$AddProductRequestFromJson(json);

  Map<String, dynamic> toJson() => _$AddProductRequestToJson(this);
}
