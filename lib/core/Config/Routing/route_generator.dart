import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/pages/main_layout.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
       return MaterialPageRoute(builder: (context) => SigninScreen(),);
      case AppRoutes.signUpRoute:
      case AppRoutes.forgetPasswordRoute:
      case AppRoutes.mainLayoutRoute:
      return MaterialPageRoute(builder: (context) => MainLayout(),);
      default:
        return unDefinedRoute();
    }
  }

  static Route<dynamic> unDefinedRoute() {
    return MaterialPageRoute(
      builder: (_) => Scaffold(
        appBar: AppBar(title: const Text('No Route Found')),
        body: const Center(child: Text('No Route Found')),
      ),
    );
  }
}
