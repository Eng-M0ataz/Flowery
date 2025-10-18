import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/order_details_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_details_entity.dart';
import 'driver_mapper.dart';
import 'order_status_history_mapper.dart';
import 'store_mapper.dart';
import 'user_mapper.dart';

extension OrderDetailsModelMapper on OrderDetailsModel {
  OrderDetailsEntity toEntity() {
    return OrderDetailsEntity(
      statusHistory: statusHistory?.toEntity(),
      driver: driver?.toEntity(),
      user: user?.toEntity(),
      store: store?.toEntity(),
    );
  }
}
