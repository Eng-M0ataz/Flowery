import 'dart:async';

import 'package:flower_e_commerce_app/Feature/trackMap/api/models/route_request_body_dto.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_event.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_state.dart';
import 'package:flower_e_commerce_app/Feature/trackMap/presentation/viewModel/track_map_view_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/driver_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/store_entity.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/domain/entities/user_entity.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CustomGoogleMap extends StatefulWidget {
  const CustomGoogleMap({
    super.key,
    required this.driver,
    required this.user,
    required this.store,
  });

  final DriverEntity driver;
  final UserEntity user;
  final StoreEntity store;

  @override
  State<CustomGoogleMap> createState() => _CustomGoogleMapState();
}

class _CustomGoogleMapState extends State<CustomGoogleMap> {
  GoogleMapController? _controller;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  BitmapDescriptor? _userIcon;
  BitmapDescriptor? _storeIcon;
  BitmapDescriptor? _driverIcon;
  final String _apiKey =
      dotenv.env['GOOGLE_MAPS_API_KEY'] ?? 'API_KEY_NOT_FOUND';

  late final TrackMapViewModel _viewModel;
  StreamSubscription<TrackMapState>? _stateSubscription;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<TrackMapViewModel>();
    _listenToStateChanges();

    _loadCustomMarkers().then((_) {
      _setMarkers();
      _requestRoute();
    });
  }

  void _listenToStateChanges() {
    _stateSubscription = _viewModel.stream.listen(
      (state) {
        if (state.routeResponse != null &&
            state.routeResponse!.routes!.isNotEmpty) {
          final encodedPolyline =
              state.routeResponse!.routes?[0].polyline?.encodedPolyline;
          _drawPolyline(encodedPolyline!);
        }
        if (state.failure != null) {
          debugPrint('Failed to get route: ${state.failure?.errorMessage}');
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                  content: Text(
                      'Error fetching route: ${state.failure?.errorMessage}')),
            );
          }
        }
      },
    );
  }

  @override
  void didUpdateWidget(covariant CustomGoogleMap oldWidget) {
    super.didUpdateWidget(oldWidget);
    final oldLocation = oldWidget.driver.driverLocation;
    final newLocation = widget.driver.driverLocation;

    if (newLocation != null && oldLocation != newLocation) {
      _setMarkers();
      _animateCameraToPosition(LatLng(newLocation.lat!, newLocation.long!));
    }
  }

  void _requestRoute() {
    final LatLng storeLocation = LatLng(
      widget.store.storeLocation?.lat ?? 30.000968,
      widget.store.storeLocation?.long ?? 31.540532,
    );

    final LatLng userLocation = LatLng(
      widget.user.userLocation?.lat ?? 30.021467,
      widget.user.userLocation?.long ?? 31.522259,
    );

    final body = RouteRequestBodyDto(
      origin: LocationDto(
        location: LatLngDto(
          latitude: storeLocation.latitude,
          longitude: storeLocation.longitude,
        ),
      ),
      destination: LocationDto(
        location: LatLngDto(
          latitude: userLocation.latitude,
          longitude: userLocation.longitude,
        ),
      ),
      travelMode: "DRIVE",
      routingPreference: "TRAFFIC_AWARE",
    );

    _viewModel.doIntent(GetRouteEvent(
      apiKey: _apiKey,
      fieldMask: 'routes.polyline.encodedPolyline',
      body: body,
    ));
  }

  Future<void> _loadCustomMarkers() async {
    _userIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(84, 84)),
      Assets.assetsImagesLocationMapIconBig,
    );
    _storeIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(84, 84)),
      Assets.assetsImagesLocationMapIconBig,
    );
    _driverIcon = await BitmapDescriptor.fromAssetImage(
      const ImageConfiguration(size: Size(84, 84)),
      Assets.assetsImagesDeliveryMotorcycleMapIconBig,
    );
    if (mounted) {
      setState(() {});
    }
  }

  void _setMarkers() {
    final LatLng userLocation = LatLng(
        widget.user.userLocation?.lat ?? 30.021467,
        widget.user.userLocation?.long ?? 31.522259);

    final LatLng storeLocation = LatLng(
        widget.store.storeLocation?.lat ?? 30.000968,
        widget.store.storeLocation?.long ?? 31.540532);

    final LatLng driverLocation = LatLng(widget.driver.driverLocation?.lat ?? 0,
        widget.driver.driverLocation?.long ?? 0);

    _markers.clear();
    _markers.addAll([
      Marker(
        markerId: const MarkerId('store'),
        position: storeLocation,
        icon: _storeIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'Store'),
      ),
      Marker(
        markerId: const MarkerId('user'),
        position: userLocation,
        icon: _userIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: const InfoWindow(title: 'You are here'),
      ),
      Marker(
        markerId: const MarkerId('driver'),
        position: driverLocation,
        icon: _driverIcon ?? BitmapDescriptor.defaultMarker,
        infoWindow: InfoWindow(title: '${widget.driver.firstName}'),
      ),
    ]);

    if (mounted) {
      setState(() {});
    }
  }

  void _drawPolyline(String encodedPolyline) {
    PolylinePoints polylinePoints = PolylinePoints();
    List<PointLatLng> result = polylinePoints.decodePolyline(encodedPolyline);

    if (result.isNotEmpty) {
      List<LatLng> polylineCoordinates = result
          .map((point) => LatLng(point.latitude, point.longitude))
          .toList();

      Polyline routePolyline = Polyline(
        polylineId: const PolylineId('route'),
        color: Theme.of(context).colorScheme.primary,
        points: polylineCoordinates,
        width: 2,
      );

      setState(() {
        _polylines.add(routePolyline);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final initialCameraPosition = CameraPosition(
      target: LatLng(
        widget.store.storeLocation?.lat ?? 30.000968,
        widget.store.storeLocation?.long ?? 31.540532,
      ),
      zoom: 14,
    );

    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      markers: _markers,
      polylines: _polylines,
      onMapCreated: (controller) {
        _controller = controller;
        _setMapStyle();
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
    );
  }

  void _setMapStyle() async {
    String style = await DefaultAssetBundle.of(context)
        .loadString('assets/mapStyles/light_style.json');
    _controller?.setMapStyle(style);
  }

  void _animateCameraToPosition(LatLng position) {
    _controller?.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(target: position, zoom: 13.5),
      ),
    );
  }

  @override
  void dispose() {
    _stateSubscription?.cancel();
    _viewModel.close();
    super.dispose();
  }
}
