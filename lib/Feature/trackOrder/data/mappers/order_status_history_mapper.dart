import 'package:flower_e_commerce_app/Feature/trackOrder/data/models/order_status_history.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_status_history_entity.dart';
import 'status_mapper.dart';

extension OrderStatusHistoryModelMapper on OrderStatusHistory {
  OrderStatusHistoryEntity toEntity() {
    return OrderStatusHistoryEntity(
      accepted: accepted?.toEntity(),
      arrived: arrived?.toEntity(),
      picked: picked?.toEntity(),
      outfordelivery: outfordelivery?.toEntity(),
      delivered: delivered?.toEntity(),
    );
  }
}
