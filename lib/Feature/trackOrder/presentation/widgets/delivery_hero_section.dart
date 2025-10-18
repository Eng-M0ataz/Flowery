import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Functions/call_number.dart';
import 'package:flower_e_commerce_app/core/Functions/open_whatsapp.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class DeliveryHeroSection extends StatelessWidget {
  final String imageUrl;

  final String name;
  final String phoneNumber;

  const DeliveryHeroSection(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CircleAvatar(
          radius: AppSizes.borderRadiusXxl_22,
          backgroundColor: AppColorsLight.white[60],
          child: ClipOval(
            child: CachedNetworkImage(
              imageUrl: imageUrl,
              fit: BoxFit.cover,
              width: AppSizes.imageProfileWidth_80,
              height: AppSizes.imageProfileHeight_80,
              placeholder: (context, url) => const Icon(
                Icons.person,
                size: AppSizes.lgIcon_36,
                color: AppColorsLight.grey,
              ),
              errorWidget: (context, url, error) => const Icon(
                Icons.error,
                size: AppSizes.lgIcon_36,
                color: AppColorsLight.red,
              ),
            ),
          ),
        ),
        SizedBox(width: AppSizes.spaceBetweenItems_4),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: Theme.of(context).textTheme.displayMedium,
            ),
            SizedBox(height: AppSizes.spaceBetweenItems_4),
            Text(
              LocaleKeys.delivery_hero_today.tr(),
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: AppColorsLight.grey,
                    fontSize: AppSizes.xsFont_12,
                  ),
            ),
          ],
        ),
        Row(
          children: [
            IconButton(
              onPressed: () => callNumber(phoneNumber),
              icon: Icon(
                Icons.call_outlined,
                color: Theme.of(context).colorScheme.primary,
                size: AppSizes.mdIcon_20,
              ),
            ),
            SizedBox(width: AppSizes.spaceBetweenItems_8),
            GestureDetector(
              onTap: () => openWhatsApp(phoneNumber),
              child: SvgPicture.asset(
                Assets.assetsImagesWhatsappIcon,
                width: AppSizes.mdIcon_20,
                height: AppSizes.mdIcon_20,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
