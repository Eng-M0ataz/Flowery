import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/pages/cart_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/pages/home_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/presentation/pages/profile_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/widgets/button_nav_bar.dart';
import 'package:flutter/material.dart';

class MainLayout extends StatefulWidget {
  const MainLayout({
    super.key,
  });

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
  final List<Widget> scrrens = [
    HomeScreen(),
    CategoryScreen(),
    CartScreen(),
    ProfileScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CustomButtonNavBar(
        currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      body: scrrens[currentIndex],
    );
  }
}
