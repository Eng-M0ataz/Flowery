import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppSizes.borderRadiusMd_8),
        border: Border.all(
          color: AppColorsLight.white[70]!,
        ),
      ),
      child: TextField(
        style: TextStyle(color: AppColorsLight.black[80]),
        decoration: InputDecoration(
          hintText: LocaleKeys.search.tr(),
          hintStyle: TextStyle(color: AppColorsLight.white[70]),
          prefixIcon: Icon(Icons.search, color: AppColorsLight.white[70]),
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd_16,
            vertical: AppSizes.paddingMd_16,
          ),
        ),
      ),
    );
  }
}
