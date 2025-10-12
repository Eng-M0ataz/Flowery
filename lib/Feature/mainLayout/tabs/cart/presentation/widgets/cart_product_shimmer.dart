import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class CartProductShimmer extends StatelessWidget {
  const CartProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: NeverScrollableScrollPhysics(),
      itemCount: 4,
      separatorBuilder: (context, index) =>
          SizedBox(height: AppSizes.spaceBetweenItems_24),
      itemBuilder: (context, index) => Container(
        padding: const EdgeInsets.all(AppSizes.paddingSm_8),
        margin: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
          border: Border.all(color: AppColorsLight.shimmerColor),
        ),
        child: Row(
          children: [
            // Image placeholder
            Shimmer(
              color: AppColorsLight.white,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
                child: Container(
                  width: AppSizes.cartImageWidth,
                  height: AppSizes.cartImageHigh,
                  color: AppColorsLight.shimmerColor,
                ),
              ),
            ),
            SizedBox(width: AppSizes.spaceBetweenItems_8),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer(
                        color: AppColorsLight.white,
                        child: Container(
                          width: AppSizes.cartProductNameWidth,
                          height: AppSizes.cartProductNameHigh,
                          decoration: BoxDecoration(
                            color: AppColorsLight.shimmerColor,
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusSm_4,
                            ),
                          ),
                        ),
                      ),
                      Shimmer(
                        color: AppColorsLight.white,
                        child: Container(
                          width: AppSizes.smIcon_16,
                          height: AppSizes.smIcon_16,
                          decoration: BoxDecoration(
                            color: AppColorsLight.shimmerColor,
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusMd_8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppSizes.spaceBetweenItems_4),
                  Shimmer(
                    color: AppColorsLight.white,
                    child: Container(
                      width: AppSizes.cartProductNameWidth * 0.8,
                      height: AppSizes.cartProductNameHigh,
                      decoration: BoxDecoration(
                        color: AppColorsLight.shimmerColor,
                        borderRadius: BorderRadius.circular(
                          AppSizes.borderRadiusSm_4,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppSizes.spaceBetweenItems_24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Shimmer(
                        color: AppColorsLight.white,
                        child: Container(
                          width: AppSizes.cartProductNameWidth * 0.5,
                          height: AppSizes.cartProductNameHigh,
                          decoration: BoxDecoration(
                            color: AppColorsLight.shimmerColor,
                            borderRadius: BorderRadius.circular(
                              AppSizes.borderRadiusMd_8,
                            ),
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Shimmer(
                            color: AppColorsLight.white,
                            child: Container(
                              width: AppSizes
                                  .cartProductPluseAndNegetiveButtonHighWidth,
                              height: AppSizes
                                  .cartProductPluseAndNegetiveButtonHighWidth,
                              decoration: BoxDecoration(
                                color: AppColorsLight.shimmerColor,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadiusMd_8,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: AppSizes.spaceBetweenItems_8),
                          Shimmer(
                            color: AppColorsLight.white,
                            child: Container(
                              width: AppSizes
                                  .cartProductPluseAndNegetiveButtonHighWidth,
                              height: AppSizes
                                      .cartProductPluseAndNegetiveButtonHighWidth +
                                  6,
                              decoration: BoxDecoration(
                                color: AppColorsLight.shimmerColor,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadiusSm_4,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: AppSizes.spaceBetweenItems_8),
                          Shimmer(
                            color: AppColorsLight.white,
                            child: Container(
                              width: AppSizes
                                  .cartProductPluseAndNegetiveButtonHighWidth,
                              height: AppSizes
                                  .cartProductPluseAndNegetiveButtonHighWidth,
                              decoration: BoxDecoration(
                                color: AppColorsLight.shimmerColor,
                                borderRadius: BorderRadius.circular(
                                  AppSizes.borderRadiusMd_8,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
