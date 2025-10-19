import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import '../../../../core/Functions/validators.dart';
import '../../../../core/localization/locale_keys.g.dart';

class GiftSection extends StatefulWidget {
  const GiftSection({super.key});

  @override
  State<GiftSection> createState() => _GiftSectionState();
}

class _GiftSectionState extends State<GiftSection> {
  bool isGift = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppSizes.paddingMd_16,
            ),
            child: Column(
              children: [
                SizedBox(height: AppSizes.spaceBetweenItems_24),
                Row(
                  children: [
                    Switch(
                        value: isGift,
                        onChanged: (value) {
                          setState(() {
                            isGift = !isGift;
                          });
                        }),
                    const SizedBox(width: AppSizes.spaceBetweenItems_8),
                    Text(
                      LocaleKeys.it_is_a_gift.tr(),
                      style: Theme.of(context).textTheme.displaySmall,
                    ),
                  ],
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_16),
                Visibility(
                  visible: isGift,
                  child: Column(
                    children: [
                      TextFormField(
                        keyboardType: TextInputType.name,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.name],
                        decoration: InputDecoration(
                          labelText: LocaleKeys.name.tr(),
                          hintText: LocaleKeys.enter_name.tr(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: Validations.validateName,
                      ),
                      const SizedBox(height: AppSizes.spaceBetweenItems_24),
                      TextFormField(
                        keyboardType: TextInputType.phone,
                        textInputAction: TextInputAction.next,
                        autofillHints: const [AutofillHints.telephoneNumber],
                        decoration: InputDecoration(
                          labelText: LocaleKeys.phone_number.tr(),
                          hintText: LocaleKeys.enter_phone_number.tr(),
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                        ),
                        validator: Validations.validatePhoneNumber,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: AppSizes.spaceBetweenItems_24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
