import 'package:flower_e_commerce_app/Feature/ordersPage/api/models/order_items_dto.dart';
import 'package:json_annotation/json_annotation.dart';
part 'orders_dto.g.dart';

@JsonSerializable()
class OrdersDto {
  @JsonKey(name: "_id")
  final String? id;
  @JsonKey(name: "user")
  final String? user;
  @JsonKey(name: "orderItems")
  final List<OrderItemsDto>? orderItems;
  @JsonKey(name: "totalPrice")
  final int? totalPrice;
  @JsonKey(name: "paymentType")
  final String? paymentType;
  @JsonKey(name: "isPaid")
  final bool? isPaid;
  @JsonKey(name: "isDelivered")
  final bool? isDelivered;
  @JsonKey(name: "state")
  final String? state;
  @JsonKey(name: "createdAt")
  final String? createdAt;
  @JsonKey(name: "updatedAt")
  final String? updatedAt;
  @JsonKey(name: "orderNumber")
  final String? orderNumber;

  OrdersDto ({
    this.id,
    this.user,
    this.orderItems,
    this.totalPrice,
    this.paymentType,
    this.isPaid,
    this.isDelivered,
    this.state,
    this.createdAt,
    this.updatedAt,
    this.orderNumber,
  });

  factory OrdersDto.fromJson(Map<String, dynamic> json) {
    return _$OrdersDtoFromJson(json);
  }

  Map<String, dynamic> toJson() {
    return _$OrdersDtoToJson(this);
  }
}
