import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ShimmerWidget extends StatelessWidget {
  final double width;
  final double height;
  final BorderRadius? borderRadius;

  const ShimmerWidget({
    super.key,
    required this.width,
    required this.height,
    this.borderRadius,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColorsLight.shimmerColor,
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppSizes.borderRadiusSm_4),
        ),
      ),
    );
  }
}
