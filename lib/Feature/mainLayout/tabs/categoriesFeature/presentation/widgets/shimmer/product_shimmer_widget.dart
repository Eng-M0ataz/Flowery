import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/shimmer/shimmer_widget.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';

class ProductCardShimmer extends StatelessWidget {
  const ProductCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusXl_16),
        border: Border.all(
          color: AppColorsLight.white[70]!,
          width: 1,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              width: double.infinity,
              margin: const EdgeInsets.all(AppSizes.paddingSm_8),
              child: ShimmerWidget(
                width: double.infinity,
                height: double.infinity,
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.paddingMd_12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ShimmerWidget(
                    width: double.infinity,
                    height: AppSizes.shimmerHeight_16,
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSm_4),
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_4),
                  Row(
                    children: [
                      Expanded(
                        child: ShimmerWidget(
                          width: AppSizes.buttonWidthSm_80,
                          height: AppSizes.buttonHigh_14,
                          borderRadius:
                              BorderRadius.circular(AppSizes.borderRadiusSm_4),
                        ),
                      ),
                      const SizedBox(width: AppSizes.spaceBetweenItems_8),
                      ShimmerWidget(
                        width: AppSizes.shimmerWidth_40,
                        height: AppSizes.shimmerProductPriceHeight_12,
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusSm_4),
                      ),
                      const SizedBox(width: AppSizes.spaceBetweenItems_8),
                      ShimmerWidget(
                        width: AppSizes.shimmerWidth_30,
                        height: AppSizes.shimmerProductPriceHeight_12,
                        borderRadius:
                            BorderRadius.circular(AppSizes.borderRadiusSm_4),
                      ),
                    ],
                  ),
                  const Spacer(),
                  ShimmerWidget(
                    width: double.infinity,
                    height: AppSizes.shimmerHeight_30,
                    borderRadius:
                        BorderRadius.circular(AppSizes.borderRadiusSm_4),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
