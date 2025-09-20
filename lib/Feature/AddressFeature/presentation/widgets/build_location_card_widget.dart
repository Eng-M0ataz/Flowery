import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LocationCard extends StatelessWidget {
  final String city;
  final String address;
  final VoidCallback? onEdit;
  final VoidCallback? onDelete;

  const LocationCard({
    super.key,
    required this.city,
    required this.address,
    this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      height: AppSizes.locationCardHeight,
      margin: const EdgeInsets.symmetric(vertical: AppSizes.paddingMd_12),
      padding: EdgeInsets.all(AppSizes.paddingMd_16),
      decoration: BoxDecoration(
        color: AppColorsLight.white,
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
        border: Border.all(color: AppColorsLight.white[60]!),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Row(
                  children: [
                    SvgPicture.asset(
                      Assets.locationIcon,
                      height: AppSizes.mdIcon_24,
                      width: AppSizes.mdIcon_24,
                    ),
                    SizedBox(width: AppSizes.paddingXs_4),
                    Text(
                      city,
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSizes.spaceBetweenItems_12),
              Expanded(
                child: Text(
                  address,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.7),
                  ),
                ),
              ),
            ],
          ),
          Spacer(),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InkWell(
                onTap: onDelete,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingXs_4),
                  child: SvgPicture.asset(
                    Assets.deleteIcon,
                    height: AppSizes.mdIcon_24,
                    width: AppSizes.mdIcon_24,
                  ),
                ),
              ),
              const SizedBox(width: AppSizes.paddingXs_4),
              // Edit button
              InkWell(
                onTap: onEdit,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusSm_4),
                child: Padding(
                  padding: const EdgeInsets.all(AppSizes.paddingXs_4),
                  child: SvgPicture.asset(
                    Assets.editIcon,
                    height: AppSizes.mdIcon_24,
                    width: AppSizes.mdIcon_24,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
