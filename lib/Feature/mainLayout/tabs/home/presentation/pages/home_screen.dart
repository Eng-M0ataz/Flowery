import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/home/presentation/widgets/homeWidgets/home_screen_body.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: HomeScreenBody(),
      ),
    );
  }
}
