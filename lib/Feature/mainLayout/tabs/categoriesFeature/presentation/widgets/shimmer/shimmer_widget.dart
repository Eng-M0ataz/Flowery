import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

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
    return Shimmer.fromColors(
      // ignore: deprecated_member_use
      baseColor: AppColorsLight.white[70]!.withOpacity(0.3),
      // ignore: deprecated_member_use
      highlightColor: AppColorsLight.white[50]!.withOpacity(0.5),
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: AppColorsLight.white,
          borderRadius:
              borderRadius ?? BorderRadius.circular(AppSizes.borderRadiusSm_4),
        ),
      ),
    );
  }
}
