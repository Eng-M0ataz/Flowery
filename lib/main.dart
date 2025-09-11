import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Routing/route_generator.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/helpers/block_observer.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_routes.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/Functions/ececute_navigation.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  final initialRoute = await getInitialRoute();
  Bloc.observer = MyBlocObserver();

  runApp(
    EasyLocalization(
      supportedLocales: AppConstants.supportedLocales,
      path: AppConstants.assetsPath,
      fallbackLocale: const Locale(AppConstants.en),
      child: FlowerECommerceApp(initialRoute: initialRoute),
    ),
  );
}

class FlowerECommerceApp extends StatelessWidget {
  const FlowerECommerceApp({super.key, required this.initialRoute});
  final String initialRoute;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      builder: (context, child) => ResponsiveBreakpoints.builder(
        child: child!,
        breakpoints: AppSizes.appBreakPoints,
        breakpointsLandscape: AppSizes.appLandscapeBreakPoints,
      ),
      theme: AppThemeLight.lightTheme,
      onGenerateRoute: RouteGenerator.getRoute,
      initialRoute: AppRoutes.ordersRoute,
    );
  }
}