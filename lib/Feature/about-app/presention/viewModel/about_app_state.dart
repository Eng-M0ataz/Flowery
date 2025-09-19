import 'package:flower_e_commerce_app/Feature/about-app/domain/entities/about_app_entity.dart';

class AboutAppState {
  final bool isLoading;
  final List<AboutAppEntity> sections;
  final String? error;

  const AboutAppState({
    required this.isLoading,
    required this.sections,
    this.error,
  });

  factory AboutAppState.initial() =>
      const AboutAppState(isLoading: false, sections: []);

  AboutAppState copyWith({
    bool? isLoading,
    List<AboutAppEntity>? sections,
    String? error,
  }) {
    return AboutAppState(
      isLoading: isLoading ?? this.isLoading,
      sections: sections ?? this.sections,
      error: error,
    );
  }
}