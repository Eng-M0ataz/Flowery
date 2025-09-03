import 'package:easy_localization/easy_localization.dart';
import 'package:flower_e_commerce_app/core/Config/Routing/route_generator.dart';
import 'package:flower_e_commerce_app/core/Config/Theme/app_theme.dart';
import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Services/storage_interface.dart';
import 'package:flower_e_commerce_app/core/helpers/block_observer.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/sizes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'core/Config/app_config_cubit.dart';
import 'core/utils/Constants/app_routes.dart' show AppRoutes;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await configureDependencies();
  Bloc.observer = MyBlocObserver();

  final initialRoute = await _getInitialRoute();

  runApp(
    EasyLocalization(
      supportedLocales: AppConstants.supportedLocales,
      path: AppConstants.assetsPath,
      fallbackLocale: const Locale(AppConstants.en),
      child: MultiBlocProvider(providers: [
        BlocProvider<AppConfigCubit>(
          create: (_) => AppConfigCubit(
            getIt<Storage>(instanceName: AppConstants.secureStorage),
          )..loadSavedLocale(),
        ),
      ], child: FlowerECommerceApp(initialRoute: initialRoute)),
    ),
  );
}

Future<String> _getInitialRoute() async {
  final storage = getIt<Storage>(instanceName: AppConstants.secureStorage);
  final rememberMeValue = await storage.read(key: AppConstants.rememberMe);

  if (rememberMeValue.toLowerCase() == 'true') {
    return AppRoutes.mainLayoutRoute;
  }
  return AppRoutes.signInRoute;
}

class FlowerECommerceApp extends StatelessWidget {
  final String initialRoute;

  const FlowerECommerceApp({super.key, required this.initialRoute});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppConfigCubit, Locale>(
      builder: (context, locale) {
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
          initialRoute: AppRoutes.profileRoute,
          onGenerateRoute: RouteGenerator.getRoute,
        );
      },
    );
  }
}
