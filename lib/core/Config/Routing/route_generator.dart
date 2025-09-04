import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/pages/best_seller_screen.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/pages/product_details_screen.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/pages/occasion_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/forget_password_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_up_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/main_layout.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flutter/material.dart';
import '../../../Feature/mainLayout/tabs/profile/presentation/pages/profile_screen.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SigninScreen());

      case AppRoutes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case AppRoutes.forgetPasswordRoute:
        return MaterialPageRoute(builder: (_) => ForgetPasswordScreen());


      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => MainLayout());

      case AppRoutes.profileRoute:
        return MaterialPageRoute(builder: (_) =>  ProfileScreen());

      case AppRoutes.occasionRoute:
        return MaterialPageRoute(builder: (_) => OccasionScreen());

      case AppRoutes.categoriesRoute:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(),
          settings: settings,
        );

      case AppRoutes.bestSellerRoute:
        return MaterialPageRoute(
          builder: (_) => const BestSellerScreen(),
          settings: settings
        );

      case AppRoutes.productDetailsRoute:
        return MaterialPageRoute(
          builder: (_) => const ProductDetailsScreen(),
          settings: settings
        );

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
