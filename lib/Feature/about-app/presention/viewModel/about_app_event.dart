abstract class AboutAppEvent {}

class LoadLocalAboutAppEvent extends AboutAppEvent {
  final String locale;
  LoadLocalAboutAppEvent(this.locale);
}