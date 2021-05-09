import 'dart:async';

/// A simple countdown timer that fires events in regular increments until a
/// duration has passed.
///
/// CountdownTimer implements [Stream] and sends itself as the event. From the
/// timer you can get the [remaining] and [elapsed] time, or [cancel] the
/// timer.
class MyCountdownTimer extends Stream<MyCountdownTimer> {
  /// Creates a new [MyCountdownTimer] that fires events in increments of
  /// [increment], until the [duration] has passed.
  ///
  /// [stopwatch] is for testing purposes. If you're using CountdownTimer and
  /// need to control time in a test, pass a mock or a fake. See [FakeAsync]
  /// and [FakeStopwatch].
  MyCountdownTimer(
    Duration duration,
    this.increment, {
    Stopwatch? stopwatch,
    this.elapsedTime,
  })  : _duration = duration,
        _stopwatch = stopwatch ?? Stopwatch(),
        _controller = StreamController<MyCountdownTimer>.broadcast(sync: true) {
    _timer = Timer.periodic(increment, _tick);
    _stopwatch.start();
  }

  static const _THRESHOLD_MS = 4;

  final Duration _duration;
  final Duration? elapsedTime;
  final Stopwatch _stopwatch;

  /// The duration between timer events.
  final Duration increment;
  final StreamController<MyCountdownTimer> _controller;
  late Timer _timer;

  @override
  StreamSubscription<MyCountdownTimer> listen(
          void onData(MyCountdownTimer event)?,
          {Function? onError,
          void onDone()?,
          bool? cancelOnError}) =>
      _controller.stream.listen(onData, onError: onError, onDone: onDone);

  Duration get elapsed => _stopwatch.elapsed + elapsedTime!;

  Duration get remaining => _duration - elapsedTime! - _stopwatch.elapsed;

  bool get isRunning => _stopwatch.isRunning;

  void cancel() {
    _stopwatch.stop();
    _timer.cancel();
    _controller.close();
  }

  void _tick(Timer timer) {
    var t = remaining;
    _controller.add(this);
    // timers may have a 4ms resolution
    if (t.inMilliseconds < _THRESHOLD_MS) {
      cancel();
    }
  }
}
