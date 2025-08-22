import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
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
          AppConstants.gender.tr(),
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(width: AppSizes.paddingMd_20),
        GenderOption(
          value: AppConstants.female,
          groupValue: selectedGender,
          label: AppConstants.female.tr(),
          activeColor: AppColorsLight.pink,
          onChanged: onChanged,
        ),
        const SizedBox(width: AppSizes.paddingMd_20),
        GenderOption(
          value: AppConstants.male,
          groupValue: selectedGender,
          label: AppConstants.male.tr(),
          activeColor: AppColorsLight.blue[80]!,
          onChanged: onChanged,
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
  final ValueChanged<String> onChanged;

  const GenderOption({
    super.key,
    required this.value,
    required this.groupValue,
    required this.label,
    required this.activeColor,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Radio<String>(
          value: value,
          groupValue: groupValue,
          onChanged: (String? newValue) {
            if (newValue != null) {
              onChanged(newValue);
            }
          },
          activeColor: activeColor,
        ),
        Text(
          label,
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ],
    );
  }
}
