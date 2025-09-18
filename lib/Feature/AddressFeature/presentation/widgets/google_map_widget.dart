import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/addressViewModel/address_view_model.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/googleMapViewModel/google_map_event.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/googleMapViewModel/google_map_state.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/viewModel/googleMapViewModel/google_map_view_model.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Functions/snack_bar.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GoogleMapWidget extends StatelessWidget {
  final double height;
  final Function(LatLng)? onSelect;
  final String? selectedAddressId;
  const GoogleMapWidget(
      {super.key, required this.height, this.onSelect, this.selectedAddressId});

  @override
  Widget build(BuildContext context) {
    final addressViewModel = context.read<AddressViewModel>();
    final state = addressViewModel.state;

    LatLng initialPosition = const LatLng(30.0439, 31.2314);
    if (state.editingAddressId != null) {
      final selected = state.addressList.firstWhere(
        (addr) => addr.id == state.editingAddressId,
        orElse: () => state.addressList.first,
      );

      final lat = double.tryParse(selected.lat ?? '') ?? 29.3569;
      final long = double.tryParse(selected.long ?? '') ?? 31.1963;
      initialPosition = LatLng(lat, long);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.read<MapViewModel>().doIntent(AddMarker(initialPosition));
      });
    }

    return BlocProvider(
      create: (_) => MapViewModel()..doIntent(InitializeMap()),
      child: BlocConsumer<MapViewModel, MapState>(
        listener: (context, state) {
          if (state.error != null) {
            showSnackBar(
              textStyle: Theme.of(context)
                  .textTheme
                  .headlineMedium!
                  .copyWith(color: AppColorsLight.white),
              context: context,
              message: state.error!,
              backgroundColor: AppColorsLight.red,
            );
          }
          if (state.currentLocation != null) {
            final addressViewModel = context.read<AddressViewModel>();

            addressViewModel.emit(
              addressViewModel.state.copyWith(
                selectedLat: state.currentLocation!.latitude.toString(),
                selectedLong: state.currentLocation!.longitude.toString(),
              ),
            );

            final address = state.address ?? '';
            addressViewModel.updateSelectedAddress(address);
          }
        },
        builder: (context, state) {
          return Container(
            width: double.infinity,
            height: height,
            decoration: BoxDecoration(
                borderRadius:
                    BorderRadius.circular(AppSizes.borderRadiusLg_12)),
            clipBehavior: Clip.hardEdge,
            child: Stack(
              children: [
                GoogleMap(
                  zoomGesturesEnabled: true,
                  scrollGesturesEnabled: true,
                  rotateGesturesEnabled: true,
                  tiltGesturesEnabled: true,
                  onTap: (pos) =>
                      context.read<MapViewModel>().doIntent(AddMarker(pos)),
                  initialCameraPosition: CameraPosition(
                    target: initialPosition,
                    zoom: AppSizes.mapCameraZoom,
                  ),
                  markers: state.markers,
                  onMapCreated: (c) =>
                      context.read<MapViewModel>().doIntent(MapCreated(c)),
                ),
                if (state.loading)
                  const Center(child: CircularProgressIndicator()),
                Positioned(
                  left: AppSizes.paddingMd_10,
                  bottom: AppSizes.paddingMd_10,
                  child: Column(
                    children: [
                      SizedBox(
                        width: AppSizes.lgIcon_32,
                        height: AppSizes.lgIcon_32,
                        child: FloatingActionButton(
                          heroTag: AppConstants.floatingHeroLoc,
                          onPressed: () => context
                              .read<MapViewModel>()
                              .doIntent(GetCurrentLocation()),
                          child: const Icon(Icons.my_location),
                        ),
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_8),
                      if (state.markers.isNotEmpty)
                        SizedBox(
                          width: AppSizes.lgIcon_32,
                          height: AppSizes.lgIcon_32,
                          child: FloatingActionButton(
                            heroTag: AppConstants.floatingHeroRemove,
                            backgroundColor: AppColorsLight.red,
                            onPressed: () => context
                                .read<MapViewModel>()
                                .doIntent(RemoveMarker()),
                            child: const Icon(Icons.delete),
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
