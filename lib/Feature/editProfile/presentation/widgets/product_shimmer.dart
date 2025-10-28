import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../core/utils/Constantts/sizes.dart';
import '../../../../../core/Config/Theme/app_colors.dart';

class ProfileShimmer extends StatelessWidget {
  const ProfileShimmer({super.key});

  Widget _buildShimmerField({required double width}) {
    return Container(
      width: width,
      height: 36,
      decoration: BoxDecoration(
        color: AppColorsLight.shimmerColor,
        borderRadius: BorderRadius.circular(AppSizes.cardRadiusLg),
      ),
    );
  }

  Widget _buildVerticalSpace() {
    return const SizedBox(height: AppSizes.spaceBetweenItems_24);
  }

  @override
  Widget build(BuildContext context) {
    return Shimmer(
      color: Theme.of(context).colorScheme.onPrimary,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_20),
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            children: [
              const SizedBox(height: AppSizes.spaceBetweenItems_8),
              CircleAvatar(
                radius: AppSizes.profileImageSize_85 / 2,
                backgroundColor: AppColorsLight.shimmerColor,
              ),
              _buildVerticalSpace(),
              Row(
                children: [
                  Expanded(child: _buildShimmerField(width: double.infinity)),
                  const SizedBox(width: 16),
                  Expanded(child: _buildShimmerField(width: double.infinity)),
                ],
              ),
              _buildVerticalSpace(),
              _buildShimmerField(width: double.infinity),
              _buildVerticalSpace(),
              _buildShimmerField(width: double.infinity),
              _buildVerticalSpace(),
              _buildShimmerField(width: 150),
              _buildVerticalSpace(),
              _buildShimmerField(width: double.infinity),
              _buildVerticalSpace(),
              _buildVerticalSpace(),
              _buildShimmerField(width: double.infinity),
            ],
          ),
        ),
      ),
    );
  }
}
