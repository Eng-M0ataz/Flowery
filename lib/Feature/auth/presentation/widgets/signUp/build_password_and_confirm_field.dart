import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
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
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: TextFormField(
          controller: passwordController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.password],
          decoration: InputDecoration(
            labelText: LocaleKeys.password_label.tr(),
            hintText: LocaleKeys.password_hint.tr(),
            labelStyle: Theme.of(context).textTheme.titleMedium,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: Validations.validatePassword,
        )),
        const SizedBox(width: AppSizes.paddingSm_8),
        Expanded(
            child: TextFormField(
          controller: confirmController,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.password],
          decoration: InputDecoration(
            labelText: LocaleKeys.confirm_password_label.tr(),
            hintText: LocaleKeys.confirm_password_hint.tr(),
            labelStyle: Theme.of(context).textTheme.titleMedium,
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: (val) =>
              Validations.validateConfirmPassword(val, passwordController.text),
        )),
      ],
    );
  }
}
