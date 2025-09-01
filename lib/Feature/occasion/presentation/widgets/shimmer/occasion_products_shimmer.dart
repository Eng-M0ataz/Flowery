import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../core/utils/Constants/sizes.dart';

class OccasionProductsShimmer extends StatelessWidget {
  final bool isEnabled;
  const OccasionProductsShimmer({super.key,required this.isEnabled});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: AppSizes.gridSpacing,
          mainAxisSpacing: AppSizes.gridSpacing,
          childAspectRatio: 0.65,
        ),
        itemCount: 6,
        itemBuilder: (context, index) => Shimmer(
          enabled: isEnabled,
          color: Colors.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColorsLight.shimmerColor,
                    borderRadius:
                        BorderRadius.circular(AppSizes.shimmerCardRadius),
                  ),
                ),
              ),
              const SizedBox(height: AppSizes.shimmerSpacingSmall),
              Container(
                height: AppSizes.shimmerLineHeight,
                width: AppSizes.shimmerLineWidthLarge,
                decoration: BoxDecoration(
                  color: AppColorsLight.shimmerColor,
                  borderRadius:
                      BorderRadius.circular(AppSizes.shimmerFullRadius),
                ),
              ),
              const SizedBox(height: AppSizes.shimmerSpacingXSmall),
              Container(
                height: AppSizes.shimmerLineHeight,
                width: AppSizes.shimmerLineWidthSmall,
                decoration: BoxDecoration(
                  color: AppColorsLight.shimmerColor,
                  borderRadius:
                      BorderRadius.circular(AppSizes.shimmerFullRadius),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
