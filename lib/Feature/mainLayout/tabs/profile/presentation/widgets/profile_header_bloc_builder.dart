import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/viewModels/profileViewModel/profile_view_model.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../../../../../core/utils/Constants/app_assets.dart';

class ProfileHeaderBlocBuilder extends StatelessWidget {
  const ProfileHeaderBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileViewModel, ProfileState>(
      builder: (context, state) {
        if (state.isLoading) {
          return _buildShimmerLoading(context);
        } else if (state.failure != null) {
          return Center(
            child: Text(state.failure?.errorMessage ?? ''),
          );
        }

        if (state.loggedUserDataResponseEntity == null ||
            state.loggedUserDataResponseEntity?.user == null) {
          return Center(
            child: Text(LocaleKeys.no_user_data.tr()),
          );
        }

        final user = state.loggedUserDataResponseEntity!.user;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: AppSizes.borderRadius_40,
              backgroundImage: NetworkImage(user?.photo ?? ''),
            ),
            SizedBox(height: AppSizes.paddingXs_4),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  user?.firstName ?? '',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(width: AppSizes.paddingXs_4),
                SvgPicture.asset(
                  Assets.assetsImagePen,
                  height: AppSizes.photoHeight_32,
                  width: AppSizes.photoWidth_32,
                  fit: BoxFit.contain,
                ),
              ],
            ),
            SizedBox(height: AppSizes.paddingXs_4),
            Text(
              user?.email ?? '',
              style: Theme.of(context)
                  .textTheme
                  .titleLarge!
                  .copyWith(color: AppColorsLight.grey),
            ),
          ],
        );
      },
    );
  }

  Widget _buildShimmerLoading(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Shimmer(
          duration: const Duration(seconds: 2),
          interval: const Duration(seconds: 1),
          color: AppColorsLight.shimmerColor,
          enabled: true,
          child: CircleAvatar(
            radius: AppSizes.borderRadius_40,
            backgroundColor: AppColorsLight.shimmerColor,
          ),
        ),
        SizedBox(height: AppSizes.paddingXs_4),
        Shimmer(
          duration: const Duration(seconds: 2),
          child: Container(
            height: AppSizes.containerHeight_20,
            width: AppSizes.containerWidth_120,
            decoration: BoxDecoration(
              color: AppColorsLight.shimmerColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
            ),
          ),
        ),
        SizedBox(height: AppSizes.paddingXs_4),
        Shimmer(
          duration: const Duration(seconds: 2),
          child: Container(
            height: AppSizes.containerHeight_16,
            width: AppSizes.containerWidth_80,
            decoration: BoxDecoration(
              color: AppColorsLight.shimmerColor,
              borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
            ),
          ),
        ),
      ],
    );
  }
}
