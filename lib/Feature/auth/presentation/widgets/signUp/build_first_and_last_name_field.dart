import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Functions/validators.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class BuildFirstAndLastNameField extends StatelessWidget {
  final TextEditingController firstNameController;
  final TextEditingController secondNameController;

  const BuildFirstAndLastNameField(
      {super.key,
      required this.firstNameController,
      required this.secondNameController});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            child: TextFormField(
          controller: firstNameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          decoration: InputDecoration(
            labelText: 'first_name_label'.tr(),
            labelStyle: Theme.of(context).textTheme.titleMedium,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            hintText: 'first_name_hint'.tr(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: Validations.validateName,
        )),
        const SizedBox(width: AppSizes.paddingSm_8),
        Expanded(
            child: TextFormField(
          controller: secondNameController,
          keyboardType: TextInputType.name,
          textInputAction: TextInputAction.next,
          autofillHints: const [AutofillHints.name],
          decoration: InputDecoration(
            labelStyle: Theme.of(context).textTheme.titleMedium,
            hintStyle: Theme.of(context).textTheme.bodyMedium,
            labelText: 'last_name_label'.tr(),
            hintText: 'last_name_hint'.tr(),
            floatingLabelBehavior: FloatingLabelBehavior.always,
          ),
          validator: Validations.validateName,
        )),
      ],
    );
  }
}
