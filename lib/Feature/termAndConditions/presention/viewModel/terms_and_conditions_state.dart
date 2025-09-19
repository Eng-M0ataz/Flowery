import 'package:flower_e_commerce_app/Feature/termAndConditions/domain/entities/terms_and_conditions_entity.dart';

class TermsAndConditionsState {
  final bool isLoading;
  final List<TermsAndConditionsEntity> sections;
  final String? error;

  const TermsAndConditionsState({
    required this.isLoading,
    required this.sections,
    this.error,
  });

  factory TermsAndConditionsState.initial() =>
      const TermsAndConditionsState(isLoading: false, sections: []);

  TermsAndConditionsState copyWith({
    bool? isLoading,
    List<TermsAndConditionsEntity>? sections,
    String? error,
  }) {
    return TermsAndConditionsState(
      isLoading: isLoading ?? this.isLoading,
      sections: sections ?? this.sections,
      error: error,
    );
  }
}