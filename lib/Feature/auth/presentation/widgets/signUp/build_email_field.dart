import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flutter/material.dart';

class BuildEmailField extends StatelessWidget {
  final TextEditingController controller;
  const BuildEmailField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.email],
      decoration: InputDecoration(
        labelText: 'email_label'.tr(),
        labelStyle: AppThemeLight.lightTheme.textTheme.titleMedium,
        hintText: 'email_hint'.tr(),
        hintStyle: AppThemeLight.lightTheme.textTheme.bodyMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: Validations.validateEmail,
    );
  }
}
