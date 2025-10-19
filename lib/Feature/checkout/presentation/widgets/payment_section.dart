import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/checkout/presentation/widgets/payment_method_item.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/localization/locale_keys.g.dart';
import '../viewModels/checkout_event.dart';
import '../viewModels/checkout_state.dart';
import '../viewModels/checkout_view_model.dart';

class PaymentSection extends StatelessWidget {
  const PaymentSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: Theme.of(context).colorScheme.onPrimary),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSizes.paddingMd_16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: AppSizes.spaceBetweenItems_24),
            Text(
              LocaleKeys.payment_method.tr(),
              style: Theme.of(context).textTheme.displaySmall,
            ),
            const SizedBox(height: AppSizes.spaceBetweenItems_16),
            BlocBuilder<CheckoutViewModel, CheckoutState>(
                builder: (context, state) {
              return Column(
                children: [
                  PaymentMethodItem(
                    isSelected: state.isCash,
                    onSelect: () {
                      context.read<CheckoutViewModel>().doIntent(
                          event: SelectPaymentMethodEvent(isCash: true));
                    },
                    title: LocaleKeys.cash_on_delivery.tr(),
                  ),
                  const SizedBox(height: AppSizes.spaceBetweenItems_8),
                  PaymentMethodItem(
                    isSelected: !state.isCash,
                    onSelect: () {
                      context.read<CheckoutViewModel>().doIntent(
                          event: SelectPaymentMethodEvent(isCash: false));
                    },
                    title: LocaleKeys.credit_card.tr(),
                  ),
                  SizedBox(
                    height: AppSizes.spaceBetweenItems_16,
                  ),
                ],
              );
            }),
          ],
        ),
      ),
    );
  }
}
