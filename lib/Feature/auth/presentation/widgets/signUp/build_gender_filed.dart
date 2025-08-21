import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flutter/material.dart';

class BuildGenderField extends StatelessWidget {
  final String selectedGender;
  final ValueChanged<String> onChanged;

  const BuildGenderField({
    super.key,
    required this.selectedGender,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'gender'.tr(),
          style: AppThemeLight.lightTheme.textTheme.titleLarge,
        ),
        const SizedBox(width: 20),

        // Female Radio Button
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: 'female'.tr(),
              groupValue: selectedGender,
              onChanged: (String? value) {
                if (value != null) {
                  onChanged(value);
                }
              },
              activeColor: AppColorsLight.pink,
            ),
            Text(
              'female'.tr(),
              style: AppThemeLight.lightTheme.textTheme.titleMedium,
            ),
          ],
        ),

        const SizedBox(width: 20),

        // Male Radio Button
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Radio<String>(
              value: 'male'.tr(),
              groupValue: selectedGender,
              onChanged: (String? value) {
                if (value != null) {
                  onChanged(value);
                }
              },
              activeColor: AppColorsLight.blue[80],
            ),
            Text(
              'male'.tr(),
              style: AppThemeLight.lightTheme.textTheme.titleMedium,
            ),
          ],
        ),
      ],
    );
  }
}
