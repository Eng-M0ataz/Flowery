import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/metadata_dto.dart';
import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/orders_dto.dart';
import 'package:json_annotation/json_annotation.dart';

part 'orders_response_dto.g.dart';

@JsonSerializable()
class OrdersResponseDto {
  @JsonKey(name: "message")
  final String? message;
  @JsonKey(name: "metadata")
  final MetaDataDto? metadata;
  @JsonKey(name: "orders")
  final List<OrdersDto>? orders;

  OrdersResponseDto ({
    this.message,
    this.metadata,
    this.orders,
  });

  factory OrdersResponseDto.fromJson(Map<String, dynamic> json) {
    return _$OrdersResponseDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersResponseDtoToJson(this);
  }
}
