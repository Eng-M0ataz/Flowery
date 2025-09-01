import 'package:flower_e_commerce_app/Feature/occasion/presentation/pages/occasion_screen.dart';
import 'package:flower_e_commerce_app/core/utils/constants/app_routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
      case AppRoutes.signUpRoute:
      case AppRoutes.forgetPasswordRoute:
      case AppRoutes.occasionRoute:
        return MaterialPageRoute(builder: (_) => OccasionScreen());
      case AppRoutes.mainLayoutRoute:
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
