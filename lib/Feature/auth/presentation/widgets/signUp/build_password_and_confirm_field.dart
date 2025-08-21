import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flutter/material.dart';

class BuildPasswordAndConfirmField extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmController;

  const BuildPasswordAndConfirmField(
      {super.key,
      required this.passwordController,
      required this.confirmController});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
            child: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.password],
          decoration: InputDecoration(
            labelText: "password_label".tr(),
            hintText: "password_hint".tr(),
            labelStyle: AppThemeLight.lightTheme.textTheme.titleMedium,
            hintStyle: AppThemeLight.lightTheme.textTheme.bodyMedium,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: Validations.validatePassword,
        )),
        SizedBox(width: 8),
        Expanded(
            child: TextFormField(
          controller: confirmController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.password],
          decoration: InputDecoration(
            labelText: "confirm_password_label".tr(),
            hintText: "confirm_password_hint".tr(),
            labelStyle: AppThemeLight.lightTheme.textTheme.titleMedium,
            hintStyle: AppThemeLight.lightTheme.textTheme.bodyMedium,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (val) =>
              Validations.validateConfirmPassword(val, passwordController.text),
        )),
      ],
    );
  }
}
