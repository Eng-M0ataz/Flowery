import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/order_details_entity.dart';
import 'package:flower_e_commerce_app/core/errors/failure.dart';

class TrackOrderState {
  TrackOrderState({
    this.isListening = false,
    this.failure,
    this.entity,
  });

  final bool isListening;
  final Failure? failure;
  final OrderDetailsEntity? entity;

  TrackOrderState copyWith({
    bool? isListening,
    Failure? failure,
    OrderDetailsEntity? entity,
  }) {
    return TrackOrderState(
      isListening: isListening ?? this.isListening,
      failure: failure ?? this.failure,
      entity: entity ?? this.entity,
    );
  }
}
