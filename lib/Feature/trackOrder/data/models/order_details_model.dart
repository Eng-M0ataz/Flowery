import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/driver_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/order_status_history.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/store_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/user_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_details_model.g.dart';

@JsonSerializable(explicitToJson: true)
class OrderDetailsModel {
  const OrderDetailsModel({
    this.statusHistory,
    this.driver,
    this.user,
    this.store,
  });

  factory OrderDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$OrderDetailsModelFromJson(json);

  @JsonKey(name: 'statusHistory')
  final OrderStatusHistory? statusHistory;

  @JsonKey(name: 'driver')
  final DriverModel? driver;

  @JsonKey(name: 'user')
  final UserModel? user;

  @JsonKey(name: 'store')
  final StoreModel? store;

  Map<String, dynamic> toJson() => _$OrderDetailsModelToJson(this);
}
