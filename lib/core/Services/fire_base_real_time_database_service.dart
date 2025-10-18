import 'dart:async';
import 'package:firebase_database/firebase_database.dart';
import 'package:flower_e_commerce_app/core/Services/real_time_database_service.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: RealTimeDataBaseService)
@Named(AppConstants.firebaseRealTimeDatabase)
class FirebaseRealTimeDatabaseService implements RealTimeDataBaseService {
  FirebaseRealTimeDatabaseService();

  final DatabaseReference _ref = FirebaseDatabase.instance.ref();

  @override
  Future<void> create(String path, Map<String, dynamic> data) async {
    await _ref.child(path).set(data);
  }

  @override
  Future<void> delete(String path) async {
    await _ref.child(path).remove();
  }

  @override
  Future<Map<String, dynamic>?> read(String path) async {
    final snapshot = await _ref.child(path).get();
    return snapshot.value as Map<String, dynamic>?;
  }

  @override
  Future<void> update(String path, Map<String, dynamic> data) async {
    await _ref.child(path).update(data);
  }

  @override
  Stream<Map<String, dynamic>> listenData(String path) {
    return _ref.child(path).onValue.map((event) {
      final value = event.snapshot.value;
      if (value == null) {
        return <String, dynamic>{};
      }
      if (value is Map) {
        return Map<String, dynamic>.from(value);
      }
      return <String, dynamic>{};
    });
  }

}
