import 'dart:convert';
import 'dart:io';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';
import 'package:flutter_record_lesson/core/widgets/my_countdown_timer.dart';
import 'package:flutter_record_lesson/core/widgets/my_error_widget.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/painter_controller.dart';
import 'package:flutter_record_lesson/utils/extensions/behavior_subject.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

class PlayLessonPage extends StatefulWidget {
  PlayLessonPage({this.lessonId});

  final String lessonId;

  @override
  _PlayLessonPageState createState() => _PlayLessonPageState();
}

class _PlayLessonPageState extends State<PlayLessonPage> {
  final _subject = BehaviorSubject<Lesson>();

  PainterController _paintController;

  MyCountdownTimer countDownTimer;

  Duration remainingDuration;

  int _imageIndex = 0;

  final _paintKey = GlobalKey();

  Stopwatch stopWatch;

  var eventList = <MyEvent>[];

  final int _eventChunkSize = 500;
  int _lastEventTime = 0;

  AudioPlayer audioPlayer = AudioPlayer();

  bool _showVideoControls = false;

  String _audioPath;

  Duration _pauseDuration;

  Lesson get lesson => _subject.value;

  @override
  void initState() {
    super.initState();
    _paintController = PainterController(
      backgroundColor: Colors.transparent,
      drawColor: Colors.greenAccent.withOpacity(0.4),
      thickness: 28,
    );
    init();
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
        body: StreamBuilder<Lesson>(
            stream: _subject,
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return SingleChildScrollView(
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
                                          imageUrl: lesson.images[_imageIndex],
                                          placeholder: (context, url) => Center(
                                              child:
                                                  CircularProgressIndicator()),
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
                                                    (countDownTimer
                                                            ?.isRunning ??
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
                                                          margin:
                                                              EdgeInsets.only(
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
                                                                  (Duration(milliseconds: lesson.duration) -
                                                                          remainingDuration)
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
                                                                if (lesson !=
                                                                    null)
                                                                  Expanded(
                                                                    child:
                                                                        SliderTheme(
                                                                      data: SliderTheme.of(
                                                                              context)
                                                                          .copyWith(
                                                                        thumbShape:
                                                                            RoundSliderThumbShape(enabledThumbRadius: 8.0),
                                                                      ),
                                                                      child:
                                                                          Slider(
                                                                        value: (lesson.duration -
                                                                                (remainingDuration?.inMilliseconds ?? 0))
                                                                            .toDouble(),
                                                                        min:
                                                                            0.0,
                                                                        max: lesson
                                                                            .duration
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
                                                                if (lesson !=
                                                                    null)
                                                                  Text(
                                                                    Duration(
                                                                            milliseconds: lesson
                                                                                .duration)
                                                                        .toString()
                                                                        .split('.')[
                                                                            0]
                                                                        .padLeft(
                                                                            8,
                                                                            '0')
                                                                        .substring(
                                                                            3,
                                                                            8),
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
                                                                  child:
                                                                      Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
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
                                                    !countDownTimer.isRunning)
                                                ? false
                                                : true,
                                            child: AnimatedOpacity(
                                              opacity: (countDownTimer ==
                                                          null ||
                                                      !countDownTimer.isRunning)
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
                                                            !countDownTimer
                                                                .isRunning)
                                                        ? FloatingActionButton(
                                                            onPressed: () {
                                                              _startVideo(
                                                                elapsedTime:
                                                                    _pauseDuration
                                                                        ?.inMilliseconds
                                                                        ?.toDouble(),
                                                              );
                                                              _pauseDuration =
                                                                  null;
                                                            },
                                                            child: Icon(
                                                              Icons.play_arrow,
                                                              color:
                                                                  Colors.white,
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
                        title: Text("${lesson.name ?? "---"}"),
                        subtitle: Text("${lesson.description ?? "---"}"),
                      ),
                      Divider(
                        height: 1,
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return MyErrorWidget(snapshot.error);
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            }),
      ),
    );
  }

  Future<void> _onStop() async {
    try {
      print('on stop');
      audioPlayer?.stop();
    } catch (e, s) {
      print(e);
    }
  }

  Future<void> init() async {
    try {
      _subject.addDataSafely(null);
      final events = await _loadEvents();
      await _loadAudio();

      final doc = await FirebaseFirestore.instance
          .doc('lessons/${widget.lessonId}')
          .get();
      _subject.add(
        Lesson.fromJson(doc.data()).copyWith(id: doc.id, events: events),
      );

      lesson.images.forEach((element) {
        precacheImage(
          CachedNetworkImageProvider(element),
          context,
        );
      });
    } catch (e, s) {
      print(e);
      _subject.addErrorSafely(e);
    }
  }

  void _onTick(Duration elapsed) {
    RenderBox box = _paintKey.currentContext.findRenderObject();
    final height = box.size.height;
    final width = box.size.width;

    if (eventList.isEmpty) {
      eventList = _getNextList();
    }

    final events = eventList.where((element) =>
        (elapsed.inMilliseconds - 25 < element.time) &&
        (element.time < elapsed.inMilliseconds + 25));
    if (events != null) {
      events.forEach((event) {
        if (event.event == Events.changeImage) {
          _paintController.clear();
          setState(() {
            _imageIndex = event.index;
          });
        } else if (event.event == Events.pointerStart) {
          _paintController.onPointerStart(event.x * width, event.y * height);
        } else if (event.event == Events.pointerMove) {
          _paintController.onPointerMove(event.x * width, event.y * height);
        } else if (event.event == Events.pointerEnd) {
          _paintController.onPointerEnd();
        }
      });
      eventList.removeWhere((element) => events.contains(element));
    }
  }

  void _startVideo({double elapsedTime}) async {
    _lastEventTime = elapsedTime?.toInt() ?? 0;
    eventList = _getNextList();

    final newList =
        lesson.events.where((element) => element.time <= _lastEventTime);
    final item = newList.lastWhere(
        (element) => element.event == Events.changeImage,
        orElse: () => null);

    final lastMoveEvent = newList.lastWhere(
        (element) => element.event == Events.pointerMove,
        orElse: () => null);

    setState(() {
      _imageIndex = item?.index ?? 0;
      countDownTimer?.cancel();
      _paintController.onPointerStart(lastMoveEvent?.x, lastMoveEvent?.y);

      this.remainingDuration = Duration(
        milliseconds: lesson.duration - (elapsedTime?.toInt() ?? 0),
      );
    });

    countDownTimer = MyCountdownTimer(
        Duration(
          milliseconds: lesson.duration,
        ),
        Duration(milliseconds: 1),
        elapsedTime: Duration(milliseconds: elapsedTime?.toInt() ?? 0));
    countDownTimer.listen((event) {
      if (mounted) {
        setState(() {
          this.remainingDuration = event.remaining;
        });
        _onTick(event.elapsed);
        if (event.remaining.inMilliseconds <
            Duration(milliseconds: 20).inMilliseconds) {
          _imageIndex = 0;
          _paintController.clear();
        }
      }
    });
    await audioPlayer.play(_audioPath, isLocal: true);

    await audioPlayer.seek(Duration(milliseconds: elapsedTime?.toInt() ?? 0));
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

  List<MyEvent> _getNextList({int fromTime}) {
    final list = lesson.events
        .where((element) =>
            element.time > (fromTime ?? _lastEventTime) &&
            element.time < (fromTime ?? _lastEventTime) + 5000)
        .toList();
    _lastEventTime = list?.last?.time ?? lesson.events.last.time;
    return list;
  }

  Future<List<MyEvent>> _loadEvents() async {
    final storageReference =
        FirebaseStorage().ref().child('lessons/${widget.lessonId}/events.json');
    var directory = await getTemporaryDirectory();
    final path = p.join(directory.path, '${widget.lessonId}/events.json');
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    final task = storageReference.writeToFile(file);
    await task.future;
    final events =
        ((jsonDecode(file.readAsStringSync()) as Map)['events'] as List)
            .map((e) => MyEvent.fromJson(e))
            .cast<MyEvent>()
            .toList();
    return events;
  }

  Future<void> _loadAudio() async {
    final storageReference =
        FirebaseStorage().ref().child('lessons/${widget.lessonId}/audio.aac');
    var directory = await getTemporaryDirectory();
    final path = p.join(directory.path, '${widget.lessonId}/audio.aac');
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    final task = storageReference.writeToFile(file);
    await task.future;

    _audioPath = path;
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

  _onPauseVideo() {
    _pauseDuration = countDownTimer.elapsedTime;

    audioPlayer?.pause();
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
    _subject.close();
    countDownTimer?.cancel();
    audioPlayer?.stop();
    audioPlayer?.dispose();
    super.dispose();
  }
}
