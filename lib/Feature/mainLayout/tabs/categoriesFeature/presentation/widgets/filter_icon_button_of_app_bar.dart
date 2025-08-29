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
          height: AppSizes.spaceBetweenItems_50,
          width: AppSizes.spaceBetweenItems_50,
          decoration: BoxDecoration(
              color: AppColorsLight.white,
              border: Border.all(
                  color: AppColorsLight.white[70] ?? Colors.transparent),
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8)),
          child: SizedBox(
            width: 16,
            height: 16,
            child: SvgPicture.asset(
              Assets.filterIcon,
              fit: BoxFit.contain,
            ),
          ),
        ));
  }
}
