import 'dart:ui';
import 'package:flower_e_commerce_app/core/Services/storage_interface.dart';
import 'package:flower_e_commerce_app/core/utils/Constantts/app_constants.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
@injectable
class AppConfigCubit extends Cubit<Locale> {
  final Storage _storage;

  AppConfigCubit(@Named(AppConstants.secureStorage) this._storage)
      : super(const Locale(AppConstants.en));

  Future<void> loadSavedLocale() async {
    final code = await _storage.read(key: AppConstants.languageCode);
    if (code.isNotEmpty) {
      emit(Locale(code));
    }
  }

  Future<void> changeLanguage(Locale locale) async {
    await _storage.write(
      key: AppConstants.languageCode,
      value: locale.languageCode,
    );
    emit(locale);
  }
}
