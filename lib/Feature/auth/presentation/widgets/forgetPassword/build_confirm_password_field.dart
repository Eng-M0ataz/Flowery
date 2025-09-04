import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flutter/material.dart';
import '../../../../../core/localization/locale_keys.g.dart';

class BuildConfirmPasswordField extends StatelessWidget {
  final TextEditingController passwordController;
  final TextEditingController confirmController;

  const BuildConfirmPasswordField(
      {super.key,
      required this.confirmController,
      required this.passwordController});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: confirmController,
      keyboardType: TextInputType.visiblePassword,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.password],
      decoration: InputDecoration(
        labelText: LocaleKeys.confirm_password_label.tr(),
        hintText: LocaleKeys.confirm_password_hint.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: (val) =>
          Validations.validateConfirmPassword(val, passwordController.text),
    );
  }
}
