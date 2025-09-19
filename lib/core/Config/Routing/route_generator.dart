import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/pages/best_seller_screen.dart';
import 'package:flower_e_commerce_app/Feature/notifications/presentation/pages/notification_screen.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/pages/occasion_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/main_layout.dart';




import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/pages/search_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/forget_password_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_up_screen.dart';


import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/pages/edit_profile_screen.dart';


import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/pages/edit_profile_screen.dart';


import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile/presentation/pages/edit_profile_screen.dart';

import 'package:flower_e_commerce_app/core/Utils/constants/app_routes.dart';

import 'package:flutter/material.dart';
import '../../../Feature/productDetails/presentation/page/product_details_screen.dart';
import '../../models/occasion_input_model.dart';
import '../../models/product_details_model.dart';

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

      // return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.editProfileRoute:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());



      // return MaterialPageRoute(builder: (_) => const SignUpScreen());
      case AppRoutes.editProfileRoute:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());


      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(
          builder: (_) => const MainLayout(initialIndex: 0),
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
