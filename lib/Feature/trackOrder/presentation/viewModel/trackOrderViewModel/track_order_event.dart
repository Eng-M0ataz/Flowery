sealed class TrackOrderEvent {}

class StartListeningOrderEvent extends TrackOrderEvent {
  StartListeningOrderEvent(this.path);
  final String path;
}

class StopListeningOrderEvent extends TrackOrderEvent {}
