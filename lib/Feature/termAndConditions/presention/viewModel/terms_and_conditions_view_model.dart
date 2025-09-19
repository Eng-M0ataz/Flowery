import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/useCase/terms_and_conditions_Use_Case.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/presention/viewModel/terms_and_conditions_event.dart';
import 'package:flower_e_commerce_app/Feature/termAndConditions/presention/viewModel/terms_and_conditions_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class TermsAndConditionsViewModel extends Cubit<TermsAndConditionsState> {
  final TermsAndConditionsUseCase _termsAndConditionsUseCase;

  TermsAndConditionsViewModel(this._termsAndConditionsUseCase) : super(TermsAndConditionsState.initial());

  Future<void> doIntent(TermsAndConditionsEvent intent) async {
    if (intent is LoadLocalTermsAndConditionsEvent) {
      await _loadTermsAndConditions(intent.locale);
    }
  }

  Future<void> _loadTermsAndConditions(String locale) async {
    emit(state.copyWith(isLoading: true, error: null));
    try {
      final list = await _termsAndConditionsUseCase.invoke(locale);
      emit(state.copyWith(isLoading: false, sections: list));
    } catch (e) {
      emit(state.copyWith(isLoading: false, error: e.toString()));
    }
  }
}