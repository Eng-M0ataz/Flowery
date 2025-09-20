import 'package:google_maps_flutter/google_maps_flutter.dart';

abstract class MapEvent {}

class InitializeMap extends MapEvent {}

class MapCreated extends MapEvent {
  final GoogleMapController controller;
  MapCreated(this.controller);
}

class GetCurrentLocation extends MapEvent {}

class RemoveMarker extends MapEvent {}

class AddMarker extends MapEvent {
  final LatLng position;
  AddMarker(this.position);
}
