abstract class TermsAndConditionsEvent {}

class LoadLocalTermsAndConditionsEvent extends TermsAndConditionsEvent {
  final String locale;
  LoadLocalTermsAndConditionsEvent(this.locale);
}