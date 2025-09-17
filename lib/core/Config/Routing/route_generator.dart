import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/main_layout.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/reset_password/presentation/pages/reset_password_screen.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case AppRoutes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => const ForgetPassword());
      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case AppRoutes.resetPasswordRoute:
        return MaterialPageRoute(builder: (_) =>  ResetPasswordScreen());
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
