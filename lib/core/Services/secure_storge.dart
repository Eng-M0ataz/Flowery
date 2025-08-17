import 'package:flower_e_commerce_app/core/Services/storge_interface.dart';
import 'package:flower_e_commerce_app/core/utils/Constants/app_constants.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: Storge)
@Named(AppConstants.secureStorge)
class SecureStorgeImpl implements Storge {
  final FlutterSecureStorage _storage = FlutterSecureStorage();
  @override
  Future<void> write({required String key, required String value}) async {
    await _storage.write(key: key, value: value);
  }

  @override
  Future<String> read({required String key}) async {
    return await _storage.read(key: key) ?? '';
  }

  @override
  Future<void> delete({required String key}) async {
    await _storage.delete(key: key);
  }

  @override
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }
}
