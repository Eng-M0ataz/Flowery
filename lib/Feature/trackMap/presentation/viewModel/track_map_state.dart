import 'package:flower_e_commerce_app/Feature/trackMap/domain/entities/route_response_entity.dart';
import 'package:flower_e_commerce_app/core/Errors/failure.dart';

class TrackMapState {
  final bool isLoading;
  final RouteResponseEntity? routeResponse;
  final Failure? failure;

  const TrackMapState({
    this.isLoading = false,
    this.routeResponse,
    this.failure,
  });

  TrackMapState copyWith({
    bool? isLoading,
    RouteResponseEntity? routeResponse,
    Failure? failure,
  }) {
    return TrackMapState(
      isLoading: isLoading ?? this.isLoading,
      routeResponse: routeResponse ?? this.routeResponse,
      failure: failure ?? this.failure,
    );
  }
}
