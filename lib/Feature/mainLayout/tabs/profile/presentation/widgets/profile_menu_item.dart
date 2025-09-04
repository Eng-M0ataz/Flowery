import 'package:flutter/material.dart';
import '../../../../../../core/Config/Theme/app_colors.dart';
import '../../../../../../core/utils/Constants/sizes.dart';

class ProfileMenuItem extends StatelessWidget {
  final Widget? leadingIcon;
  final Widget? trailing;
  final String title;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    this.leadingIcon,
    this.trailing,
    required this.title,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: Row(
        children: [
          leadingIcon ?? SizedBox(),
          const SizedBox(width: AppSizes.spaceBetweenItems_2),
          Text(
            title,
            style: Theme.of(context).textTheme.labelSmall,
          ),
          const Spacer(),
          InkWell(
            onTap: onTap,
            child: trailing ??
                Icon(
                  Icons.arrow_forward_ios_outlined,
                  color: AppColorsLight.grey,
                  size: AppSizes.mdIcon_24,
                ),
          ),
        ],
      ),
    );
  }
}
