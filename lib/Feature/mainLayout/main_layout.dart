import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/pages/home_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/widgets/button_nav_bar.dart';
import 'package:flutter/material.dart';


class MainLayout extends StatefulWidget {
  const MainLayout({super.key, required this.initialIndex});
  final int? initialIndex;

  @override
  State<MainLayout> createState() => _MainLayoutState();
}

class _MainLayoutState extends State<MainLayout> {
  int currentIndex = 0;
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
      body: IndexedStack(
        index: currentIndex,
        children: [
         HomeScreen(),
          CategoryScreen(),

        ],
      ),
    );
  }
}
