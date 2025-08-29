import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/presentation/pages/main_layout.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/domain/entities/product_entity.dart';
import 'package:flower_e_commerce_app/Feature/productDetails/presentatoin/pages/product_details.dart';
import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
       return MaterialPageRoute(builder: (context) => SigninScreen(),);
      case AppRoutes.signUpRoute:
      case AppRoutes.forgetPasswordRoute:
      case AppRoutes.productDetails:
      final product = settings.arguments as ProductEntity;
        return MaterialPageRoute(builder: (context) => ProductDetailsScreen(product: product,),);
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
