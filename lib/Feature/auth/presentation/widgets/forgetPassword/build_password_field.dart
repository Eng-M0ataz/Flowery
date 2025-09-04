import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flutter/material.dart';
import '../../../../../core/localization/locale_keys.g.dart';

class BuildPasswordField extends StatelessWidget {
  final TextEditingController controller;

  const BuildPasswordField({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.visiblePassword,
      decoration: InputDecoration(
        labelText: LocaleKeys.password.tr(),
        hintText: LocaleKeys.enter_password.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: Validations.validatePassword,
    );
  }
}
