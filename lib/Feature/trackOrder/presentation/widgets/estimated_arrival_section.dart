import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class EstimatedArrivalSection extends StatelessWidget {
  final String estimatedArrivalTime;

  const EstimatedArrivalSection(
      {super.key, required this.estimatedArrivalTime});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: AppSizes.paddingMd_16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.estimated_arrival.tr(),
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: AppColorsLight.grey, fontWeight: FontWeight.w500),
          ),
          SizedBox(height: AppSizes.spaceBetweenItems_16),
          Text(
            estimatedArrivalTime,
            style: Theme.of(context).textTheme.displayMedium!.copyWith(
                color: Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                fontSize: AppSizes.mdFont_16),
          ),
        ],
      ),
    );
  }
}
