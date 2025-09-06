import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_assets.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomeLogoAndSearchField extends StatelessWidget {
  const HomeLogoAndSearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.paddingMd_16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SvgPicture.asset(
            Assets.assetsImagesLogo,
          ),
          const SizedBox(
            width: AppSizes.spaceBetwwenItems_16,
          ),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    AppSizes.borderRadiusMd_8,
                  ),
                  borderSide: const BorderSide(color: AppColorsLight.grey),
                ),
                isDense: true,
                contentPadding: const EdgeInsets.all(0),
                border: OutlineInputBorder(
                  borderRadius:
                      BorderRadius.circular(AppSizes.borderRadiusXxl_24),
                  borderSide: BorderSide.none,
                ),
                hintText: LocaleKeys.search.tr(),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColorsLight.grey,
                  size: AppSizes.mdIcon_24,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
