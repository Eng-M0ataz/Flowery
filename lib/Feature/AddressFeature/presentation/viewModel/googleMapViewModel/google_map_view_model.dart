import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/googleMapViewModel/google_map_event.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/googleMapViewModel/google_map_state.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewModel extends Cubit<MapState> {
  MapViewModel() : super(const MapState());

  GoogleMapController? _controller;

  void doIntent(MapEvent event) {
    switch (event.runtimeType) {
      case InitializeMap:
        _init();
        break;
      case MapCreated:
        _controller = (event as MapCreated).controller;
        break;
      case GetCurrentLocation:
        _getCurrentLocation();
        break;
      case AddMarker:
        _addMarker((event as AddMarker).position);
        break;
      case RemoveMarker:
        _removeMarker();
        break;
    }
  }

  void _init() {
    emit(state.copyWith(markers: {}));
  }

  void _addMarker(LatLng pos) {
    final marker = Marker(
      markerId: MarkerId(pos.toString()),
      position: pos,
      infoWindow: InfoWindow(title: LocaleKeys.selected_location.tr()),
    );

    emit(state.copyWith(
      markers: {marker},
      currentLocation: pos,
    ));

    _controller?.animateCamera(CameraUpdate.newLatLngZoom(pos, 16));
    _getAddressFromLatLng(pos);
  }

  void _removeMarker() {
    emit(state.copyWith(markers: {}, currentLocation: null));
  }

  Future<void> _getCurrentLocation() async {
    emit(state.copyWith(loading: true));

    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        emit(state.copyWith(
            loading: false, error: LocaleKeys.location_service_disabled.tr()));
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          emit(state.copyWith(
              loading: false,
              error: LocaleKeys.location_permission_denied.tr()));
          return;
        }
      }
      if (permission == LocationPermission.deniedForever) {
        emit(state.copyWith(
            loading: false,
            error: LocaleKeys.location_permission_denied_forever.tr()));
        return;
      }

      Position pos = await Geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.high);

      final LatLng userLatLng = LatLng(pos.latitude, pos.longitude);

      final marker = Marker(
        markerId: MarkerId(LocaleKeys.your_location.tr()),
        position: userLatLng,
        infoWindow: InfoWindow(title: LocaleKeys.your_location.tr()),
      );

      emit(state.copyWith(
        loading: false,
        currentLocation: userLatLng,
        markers: {marker},
      ));

      _controller?.animateCamera(CameraUpdate.newLatLngZoom(userLatLng, 16));
      await _getAddressFromLatLng(userLatLng);
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  Future<void> _getAddressFromLatLng(LatLng pos) async {
    emit(state.copyWith(loading: true, error: null));
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(pos.latitude, pos.longitude);

      if (placemarks.isNotEmpty) {
        final place = placemarks.first;
        final address =
            "${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}";
        emit(state.copyWith(
          loading: false,
          address: address,
        ));
      } else {
        emit(state.copyWith(
          loading: false,
          error: LocaleKeys.no_address_found.tr(),
        ));
      }
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: "${LocaleKeys.failed_to_get_address.tr()} $e",
      ));
    }
  }
}
