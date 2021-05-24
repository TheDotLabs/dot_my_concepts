import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';
import 'package:flutter_record_lesson/core/widgets/my_countdown_timer.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/circular_loading.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/painter_controller.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';

import 'bloc.dart';

class PlayLessonPage extends StatefulWidget {
  const PlayLessonPage({required this.lessonId});

  final String lessonId;

  @override
  _PlayLessonPageState createState() => _PlayLessonPageState();
}

class _PlayLessonPageState extends State<PlayLessonPage> {
  late final _bloc = Bloc(widget.lessonId);

  PainterController? _paintController;
  MyCountdownTimer? countDownTimer;
  Duration? remainingDuration;
  int? _imageIndex = 0;
  final _paintKey = GlobalKey();
  Stopwatch? stopWatch;
  List<MyEvent> eventList = <MyEvent>[];
  AudioPlayer audioPlayer = AudioPlayer();
  bool _showVideoControls = false;
  var _pauseDuration = Duration(milliseconds: 0);
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    init();
  }

  Future<void> init() async {
    try {
      setState(() {
        _loading = true;
      });
      _paintController = PainterController(
        backgroundColor: Colors.transparent,
        drawColor: Colors.greenAccent.withOpacity(0.4),
        thickness: 28,
      );
      await _bloc.init(widget.lessonId);
    } catch (e, s) {
      logger.e(e, s);
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        appBar: (MediaQuery.of(context).orientation == Orientation.landscape)
            ? null
            : AppBar(
                title: Text("View Lesson"),
              ),
        body: _loading
            ? Center(
                child: CircularLoading(),
              )
            : SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    GestureDetector(
                      onTap: _onVideoTap,
                      child: Container(
                        alignment: Alignment.center,
                        color: Colors.black87,
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            maxHeight: (MediaQuery.of(context).orientation ==
                                    Orientation.landscape)
                                ? MediaQuery.of(context).size.height
                                : 500,
                          ),
                          child: AspectRatio(
                            aspectRatio: LessonConstants.aspectRatio,
                            child: Container(
                              child: IntrinsicWidth(
                                child: IntrinsicHeight(
                                  child: Stack(
                                    fit: StackFit.expand,
                                    children: [
                                      CachedNetworkImage(
                                        imageUrl:
                                            _bloc.lesson!.images![_imageIndex!],
                                        placeholder: (context, url) =>
                                            Center(child: CircularLoading()),
                                        errorWidget: (context, url, error) =>
                                            Icon(Icons.error),
                                      ),
                                      Container(
                                        key: _paintKey,
                                        child: Painter(
                                          _paintController,
                                          () {},
                                          disableTouch: true,
                                        ),
                                      ),
                                      if (MediaQuery.of(context)
                                              .platformBrightness ==
                                          Brightness.dark)
                                        Positioned.fill(
                                          child: Container(
                                            decoration: BoxDecoration(
                                              color: Colors.black38,
                                            ),
                                          ),
                                        ),
                                      Positioned.fill(
                                        child: IgnorePointer(
                                          ignoring: _showVideoControls &&
                                                  (countDownTimer?.isRunning ??
                                                      false)
                                              ? false
                                              : true,
                                          child: AnimatedOpacity(
                                            opacity: _showVideoControls &&
                                                    (countDownTimer
                                                            ?.isRunning ??
                                                        false)
                                                ? 1.0
                                                : 0.0,
                                            duration:
                                                Duration(milliseconds: 200),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black
                                                    .withOpacity(0.78),
                                              ),
                                              child: Column(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Container(
                                                        margin: EdgeInsets.only(
                                                          top: 44,
                                                        ),
                                                        child: IconButton(
                                                          icon: Icon(
                                                            Icons.pause,
                                                            size: 36,
                                                          ),
                                                          color: Colors.white,
                                                          onPressed:
                                                              _onPauseVideo,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Container(
                                                    child: ((countDownTimer
                                                                ?.isRunning ??
                                                            false))
                                                        ? Row(
                                                            children: [
                                                              SizedBox(
                                                                width: 16,
                                                              ),
                                                              Text(
                                                                (Duration(milliseconds: _bloc.lesson!.duration!) -
                                                                        remainingDuration!)
                                                                    .toString()
                                                                    .split(
                                                                        '.')[0]
                                                                    .padLeft(
                                                                        8, '0')
                                                                    .substring(
                                                                        3, 8),
                                                                style:
                                                                    TextStyle(
                                                                  fontSize: 12,
                                                                  color: Colors
                                                                      .white,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                ),
                                                              ),
                                                              if (_bloc
                                                                      .lesson !=
                                                                  null)
                                                                Expanded(
                                                                  child:
                                                                      SliderTheme(
                                                                    data: SliderTheme.of(
                                                                            context)
                                                                        .copyWith(
                                                                      thumbShape:
                                                                          RoundSliderThumbShape(
                                                                              enabledThumbRadius: 8.0),
                                                                    ),
                                                                    child:
                                                                        Slider(
                                                                      value: (_bloc.lesson!.duration! -
                                                                              (remainingDuration?.inMilliseconds ?? 0))
                                                                          .toDouble(),
                                                                      min: 0.0,
                                                                      max: _bloc
                                                                          .lesson!
                                                                          .duration!
                                                                          .toDouble(),
                                                                      onChanged:
                                                                          (double
                                                                              value) {
                                                                        _startVideo(
                                                                          elapsedTime:
                                                                              value,
                                                                        );
                                                                      },
                                                                    ),
                                                                  ),
                                                                ),
                                                              if (_bloc
                                                                      .lesson !=
                                                                  null)
                                                                Text(
                                                                  Duration(
                                                                          milliseconds: _bloc
                                                                              .lesson!
                                                                              .duration!)
                                                                      .toString()
                                                                      .split('.')[
                                                                          0]
                                                                      .padLeft(
                                                                          8,
                                                                          '0')
                                                                      .substring(
                                                                          3, 8),
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        12,
                                                                    color: Colors
                                                                        .white,
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .bold,
                                                                  ),
                                                                ),
                                                              GestureDetector(
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                              .all(
                                                                          8.0),
                                                                  child: Icon(
                                                                    Icons
                                                                        .fullscreen,
                                                                    color: Colors
                                                                        .white,
                                                                  ),
                                                                ),
                                                                onTap: () {
                                                                  _onFullScreenClick();
                                                                },
                                                              ),
                                                              SizedBox(
                                                                width: 8,
                                                              ),
                                                            ],
                                                          )
                                                        : Container(),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned.fill(
                                        child: IgnorePointer(
                                          ignoring: (countDownTimer == null ||
                                                  !countDownTimer!.isRunning)
                                              ? false
                                              : true,
                                          child: AnimatedOpacity(
                                            opacity: (countDownTimer == null ||
                                                    !countDownTimer!.isRunning)
                                                ? 1.0
                                                : 0.0,
                                            duration:
                                                Duration(milliseconds: 200),
                                            child: Container(
                                              decoration: BoxDecoration(
                                                color: Colors.black54,
                                              ),
                                              child: Center(
                                                child: Container(
                                                  child: (countDownTimer ==
                                                              null ||
                                                          !countDownTimer!
                                                              .isRunning)
                                                      ? FloatingActionButton(
                                                          onPressed: () {
                                                            _startVideo(
                                                              elapsedTime:
                                                                  _pauseDuration
                                                                      .inMilliseconds
                                                                      .toDouble(),
                                                            );
                                                            _pauseDuration =
                                                                Duration(
                                                                    milliseconds:
                                                                        0);
                                                          },
                                                          child: Icon(
                                                            Icons.play_arrow,
                                                            color: Colors.white,
                                                            size: 32,
                                                          ),
                                                        )
                                                      : Container(),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    ListTile(
                      title: Text("${_bloc.lesson!.name}"),
                      subtitle: Text("${_bloc.lesson!.description}"),
                    ),
                    Divider(
                      height: 1,
                    ),
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _onStop() async {
    try {
      await audioPlayer.stop();
    } catch (e, s) {
      logger.e(e, s);
    }
  }

  void _onTick(Duration elapsed) {
    final box = _paintKey.currentContext!.findRenderObject() as RenderBox;
    final height = box.size.height;
    final width = box.size.width;

    if (eventList.isEmpty) {
      eventList = _bloc.getNextList();
    }

    final events = eventList
      ..where((element) =>
          (elapsed.inMilliseconds - 25 < element.time!) &&
          (element.time! < elapsed.inMilliseconds + 25))
      ..forEach((event) {
        _onEvent(event, height, width);
      });
    eventList.removeWhere(events.contains);
  }

  Future<void> _startVideo({required double elapsedTime}) async {
    _bloc.lastEventTime = elapsedTime.toInt() ?? 0;
    eventList = _bloc.getNextList();

    final newList = _bloc
        .getEvents()
        .where((element) => element.time! <= _bloc.lastEventTime!);
    final item = newList
        .lastWhereOrNull((element) => element.event == Events.changeImage);

    final lastMoveEvent = newList
        .lastWhereOrNull((element) => element.event == Events.pointerMove);

    setState(() {
      _imageIndex = item?.index ?? 0;
      countDownTimer?.cancel();
      _paintController!
          .onPointerStart(lastMoveEvent?.x ?? 0, lastMoveEvent?.y ?? 0);

      remainingDuration = Duration(
        milliseconds: _bloc.lesson!.duration! - (elapsedTime.toInt() ?? 0),
      );
    });

    countDownTimer = MyCountdownTimer(
        Duration(
          milliseconds: _bloc.lesson!.duration!,
        ),
        Duration(milliseconds: 1),
        elapsedTime: Duration(milliseconds: elapsedTime.toInt() ?? 0));
    countDownTimer!.listen((event) {
      if (mounted) {
        setState(() {
          remainingDuration = event.remaining;
        });
        _onTick(event.elapsed);
        if (event.remaining.inMilliseconds <
            Duration(milliseconds: 20).inMilliseconds) {
          _imageIndex = 0;
          _paintController!.clear();
        }
      }
    });
    await audioPlayer.play(_bloc.audioPath, isLocal: true);

    await audioPlayer.seek(Duration(milliseconds: elapsedTime.toInt() ?? 0));
  }

  void _onFullScreenClick() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }

  void _onVideoTap() {
    setState(() {
      _showVideoControls = true;
    });
    Future.delayed(Duration(seconds: 2)).then((value) {
      if (mounted) {
        setState(() {
          _showVideoControls = false;
        });
      }
    });
  }

  void _onPauseVideo() {
    _pauseDuration = countDownTimer!.elapsedTime ?? Duration(milliseconds: 0);
    audioPlayer.pause();
    countDownTimer?.cancel();
  }

  Future<bool> _onWillPop() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      _onFullScreenClick();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    _bloc.dispose();
    countDownTimer?.cancel();
    audioPlayer.stop();
    audioPlayer.dispose();
    super.dispose();
  }

  void _onEvent(MyEvent event, double height, double width) {
    if (event.event == Events.changeImage) {
      _paintController!.clear();
      setState(() {
        _imageIndex = event.index;
      });
    } else if (event.event == Events.pointerStart) {
      _paintController!.onPointerStart(event.x! * width, event.y! * height);
    } else if (event.event == Events.pointerMove) {
      _paintController!.onPointerMove(event.x! * width, event.y! * height);
    } else if (event.event == Events.pointerEnd) {
      _paintController!.onPointerEnd();
    }
  }
}
