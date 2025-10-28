import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../../../../../core/utils/Constantts/app_assets.dart';
import '../viewModels/profileViewModel/profile_main_event.dart' show GetLoggedUserDataEvent;
import '../viewModels/profileViewModel/profile_main_state.dart';
import '../viewModels/profileViewModel/profile_main_view_model.dart';

class ProfileHeaderBlocBuilder extends StatelessWidget {
  const ProfileHeaderBlocBuilder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileMainViewModel, ProfileMainState>(
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
              radius: AppSizes.borderRadiusXxxl_40,
              backgroundColor: Colors.grey.shade200,
              child: ClipOval(
                child: CachedNetworkImage(
                  imageUrl: user?.photo ?? '',
                  fit: BoxFit.cover,
                  width: 80,
                  height: 80,
                  placeholder: (context, url) => const Icon(Icons.person,
                      size: AppSizes.lgIcon_36, color: AppColorsLight.grey),
                  errorWidget: (context, url, error) => const Icon(
                    Icons.error,
                    size: AppSizes.lgIcon_36,
                    color: AppColorsLight.red,
                  ),
                ),
              ),
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
                GestureDetector(
                  onTap: () async {
                    final result = await context.pushNamed(AppRoutes.editProfileRoute);

                    if (result == true) {
                      context.read<ProfileMainViewModel>().doIntend(GetLoggedUserDataEvent());
                    }
                  },
                  child: SvgPicture.asset(
                    Assets.assetsImagesNotoV1Pen,
                    height: AppSizes.photoHeight_32,
                    width: AppSizes.photoWidth_32,
                    fit: BoxFit.contain,
                  ),
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
            radius: AppSizes.borderRadiusXxxl_40,
            backgroundColor: AppColorsLight.shimmerColor,
          ),
        ),
        SizedBox(height: AppSizes.paddingXs_4),
        Shimmer(
          duration: const Duration(seconds: 2),
          child: Container(
            height: 20,
            width: 120,
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
            height: 16,
            width: 80,
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
