import 'dart:async';

UtilTimer timer = UtilTimer();

class UtilTimer {
  int _seconds = 0;
  bool _isRunning = false;
  int _initialSeconds = 0;
  late Function _onStop;
  late Timer _timer;

  UtilTimer();

  void start(int seconds, Function onStop) {
    _seconds = seconds;
    _initialSeconds = seconds;
    _onStop = onStop;
    if (_isRunning) return;
    _isRunning = true;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_seconds <= 0) {
        stop();
      }
      _seconds--;
    });
  }

  void stop() {
    _isRunning = false;
    _timer.cancel();
    _onStop();
  }

  void reset() {
    _isRunning = false;
    _seconds = _initialSeconds;
  }
}
