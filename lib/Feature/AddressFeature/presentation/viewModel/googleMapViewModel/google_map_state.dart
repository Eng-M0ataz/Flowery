import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapState {
  final bool loading;
  final String? error;
  final Set<Marker> markers;
  final LatLng? currentLocation;
  final String? address;
  const MapState({
    this.loading = false,
    this.error,
    this.markers = const {},
    this.currentLocation,
    this.address,
  });

  MapState copyWith({
    bool? loading,
    String? error,
    Set<Marker>? markers,
    LatLng? currentLocation,
    String? address,
  }) {
    return MapState(
      loading: loading ?? this.loading,
      error: error,
      markers: markers ?? this.markers,
      currentLocation: currentLocation ?? this.currentLocation,
      address: address ?? this.address,
    );
  }
}
