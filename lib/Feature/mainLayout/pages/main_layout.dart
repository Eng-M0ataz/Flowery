import 'package:flower_e_commerce_app/Feature/cart/cart_screen.dart';
import 'package:flower_e_commerce_app/Feature/category/category_screen.dart';
import 'package:flower_e_commerce_app/Feature/home/home_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/viewModel/main_layout_states.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/viewModel/main_layout_view_model.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/widgets/nav_widgests.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../profile/profile_screen.dart';


class MainLayout extends StatelessWidget {
  MainLayout({super.key});

  final List<Widget> tabs = const [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<NavigationViewModel>(),
      child: BlocBuilder<NavigationViewModel, NavigationState>(
        builder: (context, model) {
          return Scaffold(
            body: tabs[model.selectedIndex],
            bottomNavigationBar: Nav_Widgets(),
          );
        },
      ),
    );
  }
}

