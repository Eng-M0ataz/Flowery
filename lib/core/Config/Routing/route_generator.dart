import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/main_layout.dart';
import 'package:flutter/material.dart';
import '../../../Feature/mainLayout/tabs/profile/presentation/pages/profile_screen.dart';
import '../../utils/Constants/app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case AppRoutes.signUpRoute:
        // return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.forgetPasswordRoute:
        // return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayout());
        case AppRoutes.profileRoute:
        return MaterialPageRoute(builder: (_) =>  ProfileScreen());
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
