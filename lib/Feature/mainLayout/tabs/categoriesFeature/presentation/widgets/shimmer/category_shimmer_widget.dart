import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/widgets/shimmer/shimmer_widget.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CategoryShimmerWidget extends StatelessWidget {
  const CategoryShimmerWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: AppSizes.spaceBetweenItems_50,
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: 5,
        itemBuilder: (context, index) {
          final tabWidths = [40.0, 80.0, 60.0, 70.0, 50.0];
          final tabWidth = tabWidths[index];

          return Container(
            margin: const EdgeInsets.only(right: AppSizes.paddingLg_24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ShimmerWidget(
                  width: tabWidth,
                  height: AppSizes.spaceBetweenItems_16,
                  borderRadius:
                      BorderRadius.circular(AppSizes.borderRadiusSm_4),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_8),
                ShimmerWidget(
                  width: tabWidth,
                  height: 3,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(AppSizes.borderRadiusMd_8),
                    topRight: Radius.circular(AppSizes.borderRadiusMd_8),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
