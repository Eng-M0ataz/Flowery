import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../../../core/Functions/validators.dart';
import '../../../../../core/localization/locale_keys.g.dart';

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
        labelText: LocaleKeys.email.tr(),
        hintText: LocaleKeys.enterEmail.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: Validations.validateEmail,
    );
  }
}
