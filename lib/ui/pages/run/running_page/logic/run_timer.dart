import 'dart:async';

class RunTimer {
  Timer? _ticker;

  void start(Function onTick) {
    _ticker?.cancel();
    _ticker = Timer.periodic(const Duration(seconds: 1), (_) => onTick());
  }

  void stop() {
    _ticker?.cancel();
  }
}
