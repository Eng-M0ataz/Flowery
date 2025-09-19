import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';
import 'package:flutter/material.dart';

class BuildPasswordField extends StatelessWidget {
  final VoidCallback onChangePressed;

  const BuildPasswordField({
    super.key,
    required this.onChangePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: TextFormField(
          controller:
              TextEditingController(text: AppConstants.passwordCharacters),
          readOnly: true,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.password],
          decoration: InputDecoration(
            labelText: LocaleKeys.password_label.tr(),
            labelStyle: Theme.of(context).textTheme.titleMedium,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            suffixIcon: TextButton(
              onPressed: onChangePressed,
              child: Text(
                LocaleKeys.change.tr(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ),
        )),
      ],
    );
  }
}
