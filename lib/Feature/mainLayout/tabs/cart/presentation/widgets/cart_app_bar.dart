import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_state.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_colors.dart';
import 'package:flower_e_commerce_app/core/Widgets/custom_app_bar.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CartAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      builder: (context, state) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(
              left: AppSizes.paddingMd_16,
              right: AppSizes.paddingMd_16,
              bottom: AppSizes.paddingSm_8,
            ),
            child: Row(
              children: [
                CustomBackButton(title: LocaleKeys.cart.tr()),
                Text(
                  ' (${(state.cartEntity?.numberOfCartItems ?? 0)} ${LocaleKeys.items.tr()})',
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall!.copyWith(color: AppColorsLight.grey),
                ),
                Spacer(),
                TextButton(
                  onPressed: () {
                    context.read<CartCubit>().doIntent(ClearUserCartEvent());
                  },
                  child: Text('Clear All'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppSizes.appBarHigh);
}
