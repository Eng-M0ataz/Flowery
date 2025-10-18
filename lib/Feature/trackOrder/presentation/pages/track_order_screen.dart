import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_event.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_state.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/viewModel/trackOrderViewModel/track_order_view_model.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/widgets/delivery_hero_section.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/widgets/estimated_arrival_section.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/widgets/order_time_line.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_elevated_button.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:easy_localization/easy_localization.dart';

class TrackOrderScreen extends StatefulWidget {
  const TrackOrderScreen({super.key, required this.path});

  final String path;

  @override
  State<TrackOrderScreen> createState() => _TrackOrderScreenState();
}

class _TrackOrderScreenState extends State<TrackOrderScreen> {
  late final TrackOrderViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = getIt<TrackOrderViewModel>();
    _viewModel.doIntend(StartListeningOrderEvent(widget.path));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomBackButton(title: LocaleKeys.order_details.tr()),
      body: BlocProvider.value(
        value: _viewModel,
        child: BlocBuilder<TrackOrderViewModel, TrackOrderState>(
          builder: (context, state) {
            if (state.entity == null) {
              return Center(
                child: Text(
                  LocaleKeys.order_pending.tr(),
                  style: TextStyle(color: AppColorsLight.red),
                ),
              );
            }

            final isLoading = state.isListening && state.entity == null;

            final driver = state.entity!.driver!;

            return SingleChildScrollView(
              child: Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(height: AppSizes.spaceBetweenItems_16),
                    EstimatedArrivalSection(
                      estimatedArrivalTime: state.isListening
                          ? LocaleKeys.fifteen_mins.tr()
                          : LocaleKeys.loading.tr(),
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_16),
                    const Divider(),
                    SizedBox(height: AppSizes.spaceBetweenItems_40),
                    Padding(
                      padding: EdgeInsets.only(left: AppSizes.paddingMd_16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          DeliveryHeroSection(
                            imageUrl: driver.driverPhotoUrl!,
                            name: '${driver.firstName!} ${driver.lastName!}',
                            phoneNumber: driver.phone!,
                          ),
                          SizedBox(height: AppSizes.spaceBetweenItems_40),
                          Center(
                            child: SvgPicture.asset(
                              Assets.assetsImagesCar,
                              width: AppSizes.lgIcon_213,
                              height: AppSizes.xlIcon_83,
                            ),
                          ),
                          SizedBox(height: AppSizes.spaceBetweenItems_40),
                          const OrderTimeLine(),
                          SizedBox(height: AppSizes.spaceBetweenItems_40),
                        ],
                      ),
                    ),
                    CustomElevatedButton(
                      onPressed: () {
                        if (state.failure != null) {
                          _viewModel
                              .doIntend(StartListeningOrderEvent(widget.path));
                        } else if (state.entity != null) {
                          context.pushNamed(AppRoutes.mapScreen);
                        }
                      },
                      isLoading: isLoading,
                      widget: Text(
                        state.failure != null
                            ? LocaleKeys.retry.tr()
                            : LocaleKeys.show_map.tr(),
                      ),
                    ),
                    SizedBox(height: AppSizes.spaceBetweenItems_40),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  @override
  void dispose() {
    _viewModel.doIntend(StopListeningOrderEvent());
    super.dispose();
  }
}
