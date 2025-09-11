import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class NotificationListTile extends StatelessWidget {
  const NotificationListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      isThreeLine: true,
      horizontalTitleGap: AppSizes.paddingSm_8,
      contentPadding: EdgeInsets.symmetric(
        horizontal: AppSizes.paddingMd_16,
      ),
      leading: Padding(
        padding: const EdgeInsets.only(top: AppSizes.paddingXs_4),
        child: SvgPicture.asset(
          Assets.assetsImagesNotification,
        ),
      ),
      titleTextStyle: Theme.of(context).textTheme.labelLarge,
      title: Text('New Offer 😍'),
      subtitleTextStyle: Theme.of(context).textTheme.labelMedium,
      subtitle: Text(
        'Lorem ipsum dolor sit amet consectetur. Tristique et mauris sem congue in felis id nec. Amet sed morbi bibendum vestibulum.',
      ),
    );
  }
}
