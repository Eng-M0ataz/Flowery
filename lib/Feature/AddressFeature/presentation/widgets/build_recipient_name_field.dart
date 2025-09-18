import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class BuildRecipientNameField extends StatelessWidget {
  final TextEditingController recipientNameController;

  const BuildRecipientNameField({
    super.key,
    required this.recipientNameController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: recipientNameController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.name],
      decoration: InputDecoration(
        labelText: LocaleKeys.recipient_name.tr(),
        labelStyle: Theme.of(context).textTheme.titleMedium,
        hintText: LocaleKeys.enter_recipient_name.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
    );
  }
}
