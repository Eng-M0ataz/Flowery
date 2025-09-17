import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_summery_widget.dart';
import 'package:flower_e_commerce_app/core/localization/locale_keys.g.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';

class CartButtomBar extends StatelessWidget {
  const CartButtomBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      height: 200,
      child: Column(
        children: [
          CartSummeryWidget(),
          SizedBox(height: AppSizes.spaceBetweenItems_8),
          ElevatedButton(
            onPressed: () {},
            child: Text(LocaleKeys.checkout.tr()),
          ),
        ],
      ),
    );
  }
}
