import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class BuildAppBar extends StatelessWidget implements PreferredSizeWidget {
  final VoidCallback? onNotificationTap;
  final int notificationCount;
  final BuildContext context;

  const BuildAppBar({
    super.key,
    this.onNotificationTap,
    this.notificationCount = 3,
    required this.context,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        LocaleKeys.edit_profile.tr(),
        style: Theme.of(context).textTheme.titleLarge,
      ),
      centerTitle: false,
      elevation: 0,
      backgroundColor: AppColorsLight.white,
      foregroundColor: AppColorsLight.black,
      actions: [
        _buildNotificationButton(),
        const SizedBox(width: AppSizes.paddingSm_12),
      ],
    );
  }

  Widget _buildNotificationButton() {
    return IconButton(
      onPressed: onNotificationTap ??
          () {
            //todo: Default notification action
          },
      icon: Stack(
        children: [
          SvgPicture.asset(
            Assets.assetsImagesNotificationBill,
            width: AppSizes.mdIcon_24,
            height: AppSizes.mdIcon_24,
          ),
          if (notificationCount > 0)
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                width: AppSizes.smIcon_16,
                height: AppSizes.smIcon_16,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: AppColorsLight.red,
                ),
                child: Center(
                  child: Text(
                    notificationCount > 9 ? '9+' : notificationCount.toString(),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: AppColorsLight.white,
                          fontSize: 10,
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
