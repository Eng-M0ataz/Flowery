import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';

class BuildAddressField extends StatelessWidget {
  final TextEditingController addressController;

  const BuildAddressField({
    super.key,
    required this.addressController,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: addressController,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      autofillHints: const [AutofillHints.addressCityAndState],
      decoration: InputDecoration(
        labelText: LocaleKeys.address.tr(),
        labelStyle: Theme.of(context).textTheme.titleMedium,
        hintText: LocaleKeys.enter_address.tr(),
        floatingLabelBehavior: FloatingLabelBehavior.always,
      ),
      validator: Validations.validateAddress,
    );
  }
}
