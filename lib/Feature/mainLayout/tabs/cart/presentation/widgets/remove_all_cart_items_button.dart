import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_events.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class RemoveAllCartItems extends StatelessWidget {
  const RemoveAllCartItems({super.key});

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Align(
        alignment: Alignment.center,
        child: ElevatedButton(
          onPressed: () {
            context.read<CartCubit>().doIntent(ClearUserCartEvent());
          },
          child: Text(LocaleKeys.remove_all_cart_items.tr()),
        ),
      ),
    );
  }
}
