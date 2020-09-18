import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_record_lesson/core/widgets/my_countdown_timer.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/painter_controller.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class PlayLessonPage extends StatefulWidget {
  PlayLessonPage({this.lessonId});

  final String lessonId;

  @override
  _PlayLessonPageState createState() => _PlayLessonPageState();
}

class _PlayLessonPageState extends State<PlayLessonPage> {
  PainterController _paintController;

  MyCountdownTimer countDownTimer;

  Duration remainingDuration;

  Lesson lesson;

  int _imageIndex = 0;

  final _paintKey = GlobalKey();

  Stopwatch stopWatch;

  var eventList = <MyEvent>[];

  final int _eventChunkSize = 500;
  int _lastEventTime = 0;

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
    return Scaffold(
      appBar: (MediaQuery.of(context).orientation == Orientation.landscape)
          ? null
          : AppBar(
              title: Text("View Lesson"),
            ),
      body: Container(
        child: lesson == null
            ? Center(
                child: CircularProgressIndicator(),
              )
            : SingleChildScrollView(
                child: Column(
                  children: [
                    ConstrainedBox(
                      constraints: BoxConstraints(
                        maxHeight: (MediaQuery.of(context).orientation ==
                                Orientation.landscape)
                            ? MediaQuery.of(context).size.height - 48
                            : 500,
                      ),
                      child: Container(
                        color: Colors.black87,
                        child: IntrinsicWidth(
                          child: IntrinsicHeight(
                            child: Stack(
                              children: [
                                CachedNetworkImage(
                                  imageUrl: lesson.images[_imageIndex],
                                  placeholder: (context, url) => Center(
                                      child: CircularProgressIndicator()),
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
                                if (MediaQuery.of(context).platformBrightness ==
                                    Brightness.dark)
                                  Positioned.fill(
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.black38),
                                    ),
                                  ),
                                if (countDownTimer == null ||
                                    !countDownTimer.isRunning)
                                  Positioned.fill(
                                    child: Container(
                                      decoration:
                                          BoxDecoration(color: Colors.black54),
                                      child: Center(
                                        child: Container(
                                          child: FloatingActionButton(
                                            onPressed: () {
                                              _startVideo();
                                            },
                                            child: Icon(
                                              Icons.play_arrow,
                                              color: Colors.white,
                                              size: 32,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                if (countDownTimer?.isRunning ?? false)
                                  Positioned(
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.fullscreen,
                                        color: Colors.black87,
                                      ),
                                      onPressed: () {
                                        _onFullScreenClick();
                                      },
                                    ),
                                    right: 4,
                                    bottom: 4,
                                  )
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    Divider(
                      height: 1,
                    ),
                    AnimatedContainer(
                      duration: Duration(milliseconds: 100),
                      curve: Curves.easeInOut,
                      height: (countDownTimer?.isRunning ?? false) ? 48 : 0,
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
                        children: [
                          if ((countDownTimer?.isRunning ?? false))
                            Text(
                              (Duration(milliseconds: lesson.duration) -
                                      remainingDuration)
                                  .toString()
                                  .split('.')[0]
                                  .padLeft(8, '0')
                                  .substring(3, 8),
                              style: TextStyle(
                                fontSize: 12,
                              ),
                            ),
                          if ((countDownTimer?.isRunning ?? false))
                            Expanded(
                              child: SliderTheme(
                                data: SliderTheme.of(context).copyWith(
                                    thumbShape: RoundSliderThumbShape(
                                        enabledThumbRadius: 8.0)),
                                child: Slider(
                                  value: (lesson.duration -
                                          (remainingDuration?.inMilliseconds ??
                                              0))
                                      .toDouble(),
                                  min: 0.0,
                                  max: lesson.duration.toDouble(),
                                  onChanged: (double value) {
                                    _startVideo(elapsedTime: value);

                                    /*setState(() {
                                    //seekToSecond(value.toInt());
                                   // value = value;
                                  });*/
                                  },
                                ),
                              ),
                            ),
                          Text(
                            Duration(milliseconds: lesson.duration)
                                .toString()
                                .split('.')[0]
                                .padLeft(8, '0')
                                .substring(3, 8),
                            style: TextStyle(
                              fontSize: 12,
                            ),
                          ),
                        ],
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (countDownTimer?.isRunning ?? false)
                          RaisedButton(
                            onPressed: countDownTimer?.isRunning ?? false
                                ? () {
                                    setState(() {
                                      countDownTimer.cancel();
                                      _paintController.clear();
                                    });
                                    _onComplete();
                                  }
                                : null,
                            child: Text("STOP"),
                          ),
                      ],
                    ),
                    /*Column(
              children: [
                ..._eventList.map(
                  (e) => Text(jsonEncode(e.toJson())),
                ),
              ],
                )*/
                  ],
                ),
              ),
      ),
    );
  }

  Future<void> _onComplete() async {
    try {
      print('on stop');
    } catch (e, s) {
      print(e);
    }
  }

  Future<void> init() async {
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
    final doc = await FirebaseFirestore.instance
        .doc('lessons/${widget.lessonId}')
        .get();
    if (mounted)
      setState(() {
        lesson =
            Lesson.fromJson(doc.data()).copyWith(id: doc.id, events: events);
      });
    lesson.images.forEach((element) {
      precacheImage(
        CachedNetworkImageProvider(element),
        context,
      );
    });
  }

  @override
  void dispose() {
    countDownTimer?.cancel();
    super.dispose();
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

  void _startVideo({double elapsedTime}) {
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
}
