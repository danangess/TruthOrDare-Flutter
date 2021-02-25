import 'dart:async';

final appBloc = AppBloc();

enum AppEvent {
  onStart,
  onInitialized,
  onStop,
}

class AppBloc {
  final _appEventController = StreamController<AppEvent>.broadcast();

  Stream<AppEvent> get appEventsStream => _appEventController.stream;

  dispatch(AppEvent appEvent) {
    switch (appEvent) {
      case AppEvent.onStart:
        _onStart();
        break;
      case AppEvent.onStop:
        _onStop();
        break;
      case AppEvent.onInitialized:
        _sinkEvent(AppEvent.onInitialized);
        break;
    }
  }

  void _sinkEvent(AppEvent appEvent) => _appEventController.sink.add(appEvent);

  _dispose() {
    _appEventController.close();
  }

  void _onStart() async {
    _onInitializeApp();
    _sinkEvent(AppEvent.onStart);
  }

  void _onStop() async {
    _dispose();
    _sinkEvent(AppEvent.onStop);
  }

  void _onInitializeApp() async {
    dispatch(AppEvent.onInitialized);
  }
}
