import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/forget_password_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_up_screen.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/pages/best_seller_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/main_layout.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/pages/edit_profile_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/presentation/pages/profile_screen.dart';
import 'package:flower_e_commerce_app/Feature/notifications/presentation/pages/notification_screen.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/pages/occasion_screen.dart';
import 'package:flower_e_commerce_app/Feature/productDetails/presentation/page/product_details_screen.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/pages/search_screen.dart';
import 'package:flower_e_commerce_app/core/models/occasion_input_model.dart';
import 'package:flower_e_commerce_app/core/models/product_details_model.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_routes.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static Route<dynamic> getRoute(RouteSettings settings) {
    switch (settings.name) {
      case AppRoutes.signInRoute:
        return MaterialPageRoute(builder: (_) => const SigninScreen());
      case AppRoutes.bestSellerRoute:
        return MaterialPageRoute(builder: (_) => BestSellerScreen());
      case AppRoutes.signUpRoute:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.occasionRoute:
        final args = settings.arguments as OccasionInputModel;
        return MaterialPageRoute(
            builder: (_) => OccasionScreen(
                  occasionInputModel: args,
                ));
      case AppRoutes.forgetPasswordRoute:
        return MaterialPageRoute(
          builder: (_) => ForgetPasswordScreen(),
        );
      case AppRoutes.editProfileRoute:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(),
        );
      case AppRoutes.notificationRoute:
        return MaterialPageRoute(
          builder: (_) => const NotificationScreen(),
        );
      case AppRoutes.categoriesRoute:
        return MaterialPageRoute(
          builder: (_) => const CategoryScreen(),
          settings: settings,
        );
      case AppRoutes.productDetailsRoute:
        final args = settings.arguments as ProductDetailsModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productDetailsModel: args),
          settings: settings,
        );
      case AppRoutes.searchRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case AppRoutes.profileRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());

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
