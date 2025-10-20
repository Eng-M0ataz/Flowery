import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OrderSuccessScreen extends StatelessWidget {
  const OrderSuccessScreen({super.key, required this.orderId});

  final String orderId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(AppSizes.paddingMd_16),
                child: SvgPicture.asset(
                  Assets.successLogo,
                  fit: BoxFit.contain,
                  width: 150,
                  height: 150,
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_24),
              Text(LocaleKeys.order_success_message.tr(),
                  textAlign: TextAlign.center,
                  style: Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(fontSize: AppSizes.xxlFont_24)),
              const SizedBox(height: AppSizes.spaceBetweenItems_32),
              SizedBox(
                width: 340,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    padding: const EdgeInsets.symmetric(
                        vertical: AppSizes.paddingMd_16),
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(AppSizes.borderRadiusXxxl_32),
                    ),
                  ),
                  onPressed: () {
                    context.pushReplacementNamed(AppRoutes.trackOrderRoute,
                        arguments: orderId);
                  },
                  child: Text(
                    LocaleKeys.track_order.tr(),
                    style: Theme.of(context).textTheme.bodySmall!.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
