import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class FilterButton extends StatelessWidget {
  const FilterButton({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: AppSizes.buttonHigh_36,
      child: FloatingActionButton.extended(
        onPressed: () {
          //todo: show filter sheet
        },
        backgroundColor: AppColorsLight.pink,
        elevation: 4,
        icon: const Icon(
          Icons.tune,
          color: AppColorsLight.white,
          size: AppSizes.mdIcon_24,
        ),
        label: Text(LocaleKeys.filter.tr(),
            style: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: AppColorsLight.white)),
      ),
    );
  }
}
