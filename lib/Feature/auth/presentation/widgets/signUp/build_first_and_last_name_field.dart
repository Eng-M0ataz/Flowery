import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flutter/material.dart';

class BuildFirstAndLastNameField extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;

  const BuildFirstAndLastNameField(
      {super.key,
      required this.firstNameController,
      required this.secondNameController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: firstNameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          decoration: InputDecoration(
            labelText: 'first_name_label'.tr(),
            labelStyle: AppThemeLight.lightTheme.textTheme.titleMedium,
            hintStyle: AppThemeLight.lightTheme.textTheme.bodyMedium,
            hintText: 'first_name_hint'.tr(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: Validations.validateName,
        )),
        const SizedBox(width: 8),
        Expanded(
            child: TextFormField(
          controller: secondNameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          decoration: InputDecoration(
            labelStyle: AppThemeLight.lightTheme.textTheme.titleMedium,
            hintStyle: AppThemeLight.lightTheme.textTheme.bodyMedium,
            labelText: 'last_name_label'.tr(),
            hintText: 'last_name_hint'.tr(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: Validations.validateName,
          
        )),
      ],
    );
  }
}
