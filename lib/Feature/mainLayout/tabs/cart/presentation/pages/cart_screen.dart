import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_cubit.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/viewModel/cart_events.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_app_bar.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_buttom_bar.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/widgets/cart_screen_body.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<CartCubit>()..doIntent(GetUserCartEvent()),
      child: Scaffold(
        appBar: CartAppBar(),
        bottomNavigationBar: CartButtomBar(),
        body: CartScreenBody(),
      ),
    );
  }
}
