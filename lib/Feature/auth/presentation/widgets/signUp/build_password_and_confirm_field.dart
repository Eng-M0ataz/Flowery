import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_password_text_form_field.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
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
          child: CustomPasswordTextFormField(
            validator: Validations.validatePassword,
            hint: LocaleKeys.password_hint.tr(),
            label: LocaleKeys.password_label.tr(),
            controller: passwordController,
          ),
        ),
        const SizedBox(width: AppSizes.paddingSm_8),
        Expanded(
          child: CustomPasswordTextFormField(
            validator: Validations.validatePassword,
            hint: LocaleKeys.confirm_password_hint.tr(),
            label: LocaleKeys.confirm_password_label.tr(),
            controller: confirmController,
          ),
        ),
      ],
    );
  }
}
