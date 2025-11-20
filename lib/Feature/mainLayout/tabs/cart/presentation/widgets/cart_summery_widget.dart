import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/summary_item.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartSummeryWidget extends StatelessWidget {
  const CartSummeryWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return Column(
          spacing: AppSizes.spaceBetweenItems_8,
          children: [
            SummaryItem(
              text: LocaleKeys.sub_total.tr(),
              price:
                  '${(state.cartEntity?.totalPrice) ?? '0.0'} ${LocaleKeys.currency.tr()}',
            ),
            SummaryItem(
              text: LocaleKeys.delivery_fee.tr(),
              price: '0.0 ${LocaleKeys.currency.tr()}',
            ),
            SummaryItem(
              isTotal: true,
              text: LocaleKeys.total.tr(),
              price:
                  '${(state.cartEntity?.totalPrice ?? "0.0").toString()} ${LocaleKeys.currency.tr()}',
            ),
          ],
        );
      },
    );
  }
}
