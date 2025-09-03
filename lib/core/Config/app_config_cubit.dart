import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import '../Services/storage_interface.dart';
import '../utils/Constants/app_constants.dart';

class AppConfigCubit extends Cubit<Locale> {
  final Storage _storage;

  AppConfigCubit(this._storage) : super(const Locale(AppConstants.en));

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
