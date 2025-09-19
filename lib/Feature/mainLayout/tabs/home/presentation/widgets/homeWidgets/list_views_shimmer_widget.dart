import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ListViewsShimmerWidget extends StatelessWidget {
  const ListViewsShimmerWidget({
    super.key,
    this.isCategorie = false,
  });
  final bool isCategorie;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isCategorie
          ? AppSizes.homeCategoriesListViewHigh
          : AppSizes.homeOccasionListViewHigh,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
        itemCount: AppSizes.homeDummyShimmerListViewItemsLength,
        scrollDirection: Axis.horizontal,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) => Shimmer(
          color: AppColorsLight.white,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: isCategorie
                    ? AppSizes.homeCategoriesImageContainerWidth
                    : AppSizes.homeOccasionImageWidth,
                height: isCategorie
                    ? AppSizes.homeCategoriesImageContainerHigh
                    : AppSizes.homeOccasionImageHigh,
                decoration: BoxDecoration(
                  color: AppColorsLight.shimmerColor,
                  borderRadius: isCategorie
                      ? BorderRadius.circular(AppSizes.borderRadiusXl_20)
                      : null,
                ),
              ),
              const SizedBox(
                height: AppSizes.spaceBetweenItems_8,
              ),
              Container(
                width: isCategorie
                    ? AppSizes.homeCategoriesImageContainerWidth
                    : AppSizes.homeDummyShimmerListViewTextWidth,
                height: AppSizes.homeDummyShimmerListViewTextHigh,
                decoration: BoxDecoration(
                  color: AppColorsLight.shimmerColor,
                  borderRadius:
                      BorderRadius.circular(AppSizes.borderRadiusFull),
                ),
              )
            ],
          ),
        ),
        separatorBuilder: (context, index) => const SizedBox(
          width: AppSizes.spaceBetweenItems_16,
        ),
      ),
    );
  }
}
