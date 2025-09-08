import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/pages/best_seller_screen.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/pages/occasion_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/main_layout.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flutter/material.dart';
import '../../../Feature/productDetails/presentation/page/product_details_screen.dart';
import '../../models/occasion_input_model.dart';
import '../../models/product_details_model.dart';
import '../../utils/constants/app_routes.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SignInScreen());
      case AppRoutes.bestSellerRoute:
        return MaterialPageRoute(builder: (_) => BestSellerScreen());
      case AppRoutes.signUpRoute:
      // return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.forgetPasswordRoute:
      case AppRoutes.occasionRoute:
      final args = settings.arguments as OccasionInputModel;
        return MaterialPageRoute(builder: (_) => OccasionScreen(
           occasionInputModel: args,
        ));

      // return MaterialPageRoute(builder: (_) => const ForgetPassword());

      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(
            builder: (_) => const MainLayout(
                  initialIndex: 0,
                ));

      case AppRoutes.categoriesRoute:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(),
          settings: settings,
        );
      case AppRoutes.productDetailsRoute:
        final args = settings.arguments as ProductDetailsModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(
            productDetailsModel: args,
          ),
          settings: settings,
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
