import 'package:flower_e_commerce_app/Feature/about-app/domain/useCase/About_App_Use_Case.dart';
import 'package:flower_e_commerce_app/Feature/about-app/presention/viewModel/about_app_event.dart';
import 'package:flower_e_commerce_app/Feature/about-app/presention/viewModel/about_app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class AboutAppViewModel extends Cubit<AboutAppState> {
  final AboutAppUseCase _aboutAppUseCase;

  AboutAppViewModel(this._aboutAppUseCase) : super(AboutAppState.initial());

  Future<void> doIntent(AboutAppEvent intent) async {
    if (intent is LoadLocalAboutAppEvent) {
      await _loadAboutApp(intent.locale);
    }
  }

  Future<void> _loadAboutApp(String locale) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final list = await _aboutAppUseCase.invoke(locale);
      emit(state.copyWith(isLoading: false, sections: list));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}