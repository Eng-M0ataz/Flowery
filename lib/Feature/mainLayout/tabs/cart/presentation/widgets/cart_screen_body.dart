import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_list_view.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_product_shimmer.dart';
import 'package:flower_e_commerce_app/core/helpers/dialogue_utils.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreenBody extends StatelessWidget {
  const CartScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        if (state.isCartQuantityFail) {
          DialogueUtils.showMessage(
            context: context,
            message: state.updateQuantityFailure!.errorMessage,
            posActionName: LocaleKeys.ok.tr(),
          );
        }
        if (state.isClearSpecificCartItemFail) {
          DialogueUtils.showMessage(
            context: context,
            message: state.clearSpecificCartItemFailure!.errorMessage,
            posActionName: LocaleKeys.ok.tr(),
          );
        }
        if (state.isClearUserCartFail) {
          DialogueUtils.showMessage(
            context: context,
            message: state.clearUserCartFailure!.errorMessage,
            posActionName: LocaleKeys.ok.tr(),
          );
        }
      },
      builder: (context, state) {
        if (state.isCartLoading) {
          return CartProductShimmer();
        }
        if (state.cartFailure != null) {
          return Center(child: Text(state.cartFailure!.errorMessage));
        }
        if (state.cartEntity!.products.isEmpty) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.shopping_bag_outlined,
                  size: AppSizes.icon_60,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Text(LocaleKeys.empty_cart.tr()),
              ],
            ),
          );
        }
        return CartListView(
          cartEntity: state.cartEntity!,
          loadingProducts: state.loadingProducts,
        );
      },
    );
  }
}
