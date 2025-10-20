import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_event.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_state.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_view_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/widgets/custom_google_map.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/widgets/delivery_hero_section.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/widgets/estimated_arrival_section.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({super.key, required this.orderId});

  final String orderId;

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late TrackOrderViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<TrackOrderViewModel>();
    _viewModel.doIntend(StartListeningOrderEvent(widget.orderId));
  }

  @override
  void dispose() {
    _viewModel.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _viewModel,
      child: Scaffold(
        body: BlocBuilder<TrackOrderViewModel, TrackOrderState>(
          builder: (context, state) {
            if (state.entity == null) {
              return const Center(child: CircularProgressIndicator());
            }

            final driver = state.entity?.driver;
            final user = state.entity?.user;
            final store = state.entity?.store;

            if (driver == null || user == null || store == null) {
              return Center(
                child: Text(LocaleKeys.waiting_for_driver.tr()),
              );
            }

            return Stack(
              children: [
                CustomGoogleMap(
                  driver: driver,
                  user: user,
                  store: store,
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    padding: const EdgeInsets.all(AppSizes.paddingMd_16)
                        .copyWith(top: AppSizes.paddingXl_32),
                    decoration: BoxDecoration(
                      color: AppColorsLight.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(AppSizes.borderRadiusXxl_24),
                        topRight: Radius.circular(AppSizes.borderRadiusXxl_24),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: AppColorsLight.black.withOpacity(0.12),
                          blurRadius: AppSizes.shadowBlurRadius_10,
                          spreadRadius: AppSizes.shadowSpreadRadius_2,
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        EstimatedArrivalSection(
                          estimatedArrivalTime: LocaleKeys.fifteen_mins.tr(),
                        ),
                        const SizedBox(height: AppSizes.spaceBetweenItems_32),
                        DeliveryHeroSection(
                          name: "${driver.firstName} ${driver.lastName}",
                          imageUrl: driver.driverPhotoUrl!,
                          phoneNumber: driver.phone!,
                        ),
                        const SizedBox(height: AppSizes.spaceBetweenItems_32),
                        CustomElevatedButton(
                          onPressed: () {
                            //todo navigate to order details
                          },
                          widget: Text(LocaleKeys.order_details.tr()),
                          isLoading: false,
                        ),
                        const SizedBox(height: AppSizes.spaceBetweenItems_8),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: AppSizes.topPosition_40,
                  left: AppSizes.paddingMd_16,
                  child: CircleAvatar(
                    backgroundColor: AppColorsLight.white,
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_outlined,
                          color: AppColorsLight.black),
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
