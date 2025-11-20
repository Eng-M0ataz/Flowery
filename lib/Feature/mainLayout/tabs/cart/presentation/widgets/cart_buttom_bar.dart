import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_state.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_summery_widget.dart';
import 'package:flower_e_commerce_app/core/helpers/routing_extensions.dart';
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
      builder: (context, state) {
        return Container(
          padding: EdgeInsets.symmetric(
            horizontal: AppSizes.paddingMd_16,
            vertical: AppSizes.paddingMd_16,
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(AppSizes.borderRadiusXl_16),
              topRight: Radius.circular(AppSizes.borderRadiusXl_16),
            ),
            color: Theme.of(context).colorScheme.onPrimary,
            boxShadow: [
              BoxShadow(
                blurRadius: 6,
                color: Colors.black12,
              )
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              CartSummeryWidget(),
              SizedBox(height: 8),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    context.pushNamed(
                      AppRoutes.checkoutRoute,
                      arguments: state.cartEntity!.totalPrice,
                    );
                  },
                  child: Text("Checkout"),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
