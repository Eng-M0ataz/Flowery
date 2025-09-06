import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class BuildGenderField extends StatelessWidget {
  final String selectedGender;

  const BuildGenderField({
    super.key,
    required this.selectedGender,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          LocaleKeys.gender.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(width: AppSizes.paddingMd_20),
        GenderOption(
          value: AppConstants.female,
          groupValue: selectedGender,
          label: LocaleKeys.female_label.tr(),
          activeColor: AppColorsLight.pink,
        ),
        const SizedBox(width: AppSizes.paddingMd_20),
        GenderOption(
          value: AppConstants.male,
          groupValue: selectedGender,
          label: LocaleKeys.male_label.tr(),
          activeColor: AppColorsLight.blue[80]!,
        ),
      ],
    );
  }
}

class GenderOption extends StatelessWidget {
  final String value;
  final String groupValue;
  final String label;
  final Color activeColor;

  const GenderOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.activeColor,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: null,
          activeColor: activeColor,
          fillColor: MaterialStateProperty.resolveWith<Color>(
            (states) {
              if (value == groupValue) {
                return activeColor;
              }
              return Colors.grey;
            },
          ),
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
