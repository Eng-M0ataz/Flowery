import 'status_entity.dart';

class OrderStatusHistoryEntity {
  final StatusEntity? accepted;
  final StatusEntity? arrived;
  final StatusEntity? picked;
  final StatusEntity? outfordelivery;
  final StatusEntity? delivered;

  const OrderStatusHistoryEntity({
    this.accepted,
    this.arrived,
    this.picked,
    this.outfordelivery,
    this.delivered,
  });
}

