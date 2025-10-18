import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/pages/add_address_screen.dart';
import 'package:flower_e_commerce_app/Feature/AddressFeature/presentation/pages/saved_address_screen.dart';
import 'package:flower_e_commerce_app/Feature/bestSellerFeature/presentation/pages/best_seller_screen.dart';
import 'package:flower_e_commerce_app/Feature/editProfile/presentation/pages/edit_profile_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/cart/presentation/pages/cart_screen.dart';
import 'package:flower_e_commerce_app/Feature/occasion/presentation/pages/occasion_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_in_screen.dart';
import 'package:flower_e_commerce_app/Feature/auth/presentation/pages/sign_up_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/main_layout.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/categoriesFeature/presentation/pages/category_screen.dart';
import 'package:flower_e_commerce_app/Feature/mainLayout/tabs/profile_main/presentation/pages/profile_screen.dart';
import 'package:flower_e_commerce_app/Feature/productDetails/presentation/page/product_details_screen.dart';
import 'package:flower_e_commerce_app/Feature/searchFeature/presentation/pages/search_screen.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/pages/map_screen.dart';
import 'package:flower_e_commerce_app/Feature/trackOrder/presentation/pages/track_order_screen.dart';
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
            builder: (_) => OccasionScreen(occasionInputModel: args));
      case AppRoutes.addAddressScreenRoute:
        return MaterialPageRoute(builder: (_) => const AddAddressScreen());
      case AppRoutes.savedAddressScreenRoute:
        return MaterialPageRoute(builder: (_) => const SavedAddressScreen());
      case AppRoutes.mainLayoutRoute:
        return MaterialPageRoute(builder: (_) => const MainLayout());
      case AppRoutes.categoriesRoute:
        return MaterialPageRoute(
            builder: (_) => const CategoryScreen(), settings: settings);
      case AppRoutes.productDetailsRoute:
        final args = settings.arguments as ProductDetailsModel;
        return MaterialPageRoute(
          builder: (_) => ProductDetailsScreen(productDetailsModel: args),
          settings: settings,
        );
      case AppRoutes.cartRoute:
        return MaterialPageRoute(builder: (context) => const CartScreen());
      case AppRoutes.searchRoute:
        return MaterialPageRoute(
          builder: (_) => const SearchScreen(),
        );
      case AppRoutes.profileRoute:
        return MaterialPageRoute(builder: (_) => ProfileScreen());
      case AppRoutes.editProfileRoute:
        return MaterialPageRoute(builder: (_) => EditProfileScreen());
      case AppRoutes.trackOrderRoute:
        return MaterialPageRoute(
            builder: (_) => TrackOrderScreen(
                  path: '68f1067a7fee68a4c2ec99a7',
                ));
      case AppRoutes.mapScreen:
        return MaterialPageRoute(builder: (_) => MapScreen(path:'68f1067a7fee68a4c2ec99a7' ,));

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
