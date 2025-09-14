import 'package:flower_e_commerce_app/core/Di/di.dart';
import 'package:flower_e_commerce_app/core/Services/storage_interface.dart';
import 'package:flower_e_commerce_app/core/utils/constants/app_constants.dart';
import 'package:flower_e_commerce_app/core/utils/constants/app_routes.dart';

Future<String> getInitialRoute() async {
  final storage = getIt<Storage>(instanceName: AppConstants.secureStorage);
  final rememberMeValue = await storage.read(key: AppConstants.rememberMe);

  if (rememberMeValue.toLowerCase() == 'true') {
    return AppRoutes.mainLayoutRoute;
  }
  return AppRoutes.signInRoute;
}
