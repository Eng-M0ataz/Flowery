import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_summery_widget.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartButtomBar extends StatelessWidget {
  const CartButtomBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CartCubit, CartState>(
      buildWhen: (previous, current) =>
          previous.cartEntity != current.cartEntity,
      builder: (context, state) {
        return BottomAppBar(
          height: 200,
          child: Column(
            children: [
              CartSummeryWidget(),
              SizedBox(height: AppSizes.spaceBetweenItems_8),
              ElevatedButton(
                onPressed: () {
                  context.pushNamed(
                    AppRoutes.checkoutRoute,
                    arguments: state.cartEntity?.totalPrice,
                  );
                },
                child: Text(LocaleKeys.checkout.tr()),
              ),
            ],
          ),
        );
      },
    );
  }
}
