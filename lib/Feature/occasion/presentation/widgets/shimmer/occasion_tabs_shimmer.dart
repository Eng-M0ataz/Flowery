import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../core/Config/Theme/app_colors.dart';
import '../../../../../core/utils/Constants/sizes.dart';

class OccasionTabsShimmer extends StatelessWidget {
  const OccasionTabsShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.tabListHeight,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: 4,
        separatorBuilder: (_, __) =>
        const SizedBox(width: AppSizes.tabItemSpacing),
        itemBuilder: (context, index) => Shimmer(
          color:Theme.of(context).colorScheme.onPrimary,
          child: Container(
            width: AppSizes.tabItemWidth,
            height: AppSizes.tabItemHeight,
            decoration: BoxDecoration(
              color: AppColorsLight.shimmerColor,
              borderRadius: BorderRadius.circular(
                AppSizes.tabItemBorderRadius,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
