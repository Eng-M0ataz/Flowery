import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flutter/material.dart';

class BuildPhoneField extends StatelessWidget {
  final TextEditingController controller;
  const BuildPhoneField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.phone,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.telephoneNumber],
      decoration: InputDecoration(
        labelText: "phone_number_label".tr(),
        hintText: "phone_number_hint".tr(),
        labelStyle: AppThemeLight.lightTheme.textTheme.titleMedium,
        hintStyle: AppThemeLight.lightTheme.textTheme.bodyMedium,
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: Validations.validatePhoneNumber,
    );
  }
}
