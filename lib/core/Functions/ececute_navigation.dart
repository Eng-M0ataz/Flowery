import '../Di/di.dart';
import '../Services/storage_interface.dart';
import '../Utils/constants/app_routes.dart';
import '../utils/Constants/app_constants.dart';

Future<String> getInitialRoute() async {
  final storage = getIt<Storage>(instanceName: AppConstants.secureStorage);
  final rememberMeValue = await storage.read(key: AppConstants.rememberMe);

  if (rememberMeValue.toLowerCase() == 'true') {
    return AppRoutes.mainLayoutRoute;
  }
  return AppRoutes.signInRoute;
}