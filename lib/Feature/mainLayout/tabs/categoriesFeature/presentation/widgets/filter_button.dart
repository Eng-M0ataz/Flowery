import 'package:easy_localization/easy_localization.dart';
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
        backgroundColor: Theme.of(context).colorScheme.primary,
        elevation: 4,
        icon: Icon(
          Icons.tune,
          color: Theme.of(context).colorScheme.onPrimary,
          size: AppSizes.mdIcon_24,
        ),
        label: Text(
          LocaleKeys.filter.tr(),
          style: Theme.of(context)
              .textTheme
              .titleSmall!
              .copyWith(color: Theme.of(context).colorScheme.onPrimary),
        ),
      ),
    );
  }
}
