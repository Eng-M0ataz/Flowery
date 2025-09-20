import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FilterIconButtonOfAppBar extends StatelessWidget {
  final VoidCallback onTap;

  const FilterIconButtonOfAppBar({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 36,
        width: 36,
        decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.onPrimary,
            border: Border.all(color: AppColorsLight.white[70]!, width: 1),
            borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8)),
        child: SizedBox(
          width: AppSizes.smIcon_16,
          height: AppSizes.smIcon_16,
          child: SvgPicture.asset(
            Assets.assetsImagesFilterIcon,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
