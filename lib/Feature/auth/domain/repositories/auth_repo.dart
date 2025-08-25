import 'package:flower_e_commerce_app/core/Errors/api_results.dart';

abstract interface class AuthRepo {
 Future <ApiResult> isGuest();
}
