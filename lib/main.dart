import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flower_e_commerce_app/core/Config/Routing/route_generator.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Functions/execute_navigation.dart';
import 'package:flower_e_commerce_app/core/helpers/block_observer.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/sizes.dart';
import 'package:flower_e_commerce_app/firebase_options.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      initialRoute: initialRoute,
    );
  }
}
