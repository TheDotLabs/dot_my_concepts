import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:collection/collection.dart' show IterableExtension;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_record_lesson/core/widgets/my_countdown_timer.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/circular_loading.dart';
import 'package:flutter_record_lesson/modules/play_lesson/src/widgets/image_container.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/background_container.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/video_play_container.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:provider/provider.dart';

import 'bloc.dart';
import 'painter_controller.dart';
import 'painter_widget.dart';
import 'widgets/video_controls_container.dart';

class PlayLessonPage extends StatefulWidget {
  const PlayLessonPage({required this.lessonId});

  final String lessonId;

  @override
  _PlayLessonPageState createState() => _PlayLessonPageState();
}

class _PlayLessonPageState extends State<PlayLessonPage> {
  late final _bloc = Bloc(widget.lessonId);

  final paintController = PainterController(
    drawColor: Colors.greenAccent.withOpacity(0.4),
  );
  MyCountdownTimer? countDownTimer;
  final _paintKey = GlobalKey();
  Stopwatch? stopWatch;
  List<MyEvent> eventList = <MyEvent>[];
  AudioPlayer audioPlayer = AudioPlayer();
  bool _showVideoControls = false;
  var _pauseDuration = Duration(milliseconds: 0);
  bool _loading = false;

  bool get _isVideoPlaying => countDownTimer?.isRunning ?? false;

  final _imageChangeNotifier = ValueNotifier<int>(0);
  final elapsedTimeNotifier = ValueNotifier<int>(0);

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
      await _bloc.init(widget.lessonId);
      for (final url in _bloc.lesson!.images!) {
        await precacheImage(
          CachedNetworkImageProvider(url),
          context,
        );
      }
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
    return Provider<Bloc>.value(
      value: _bloc,
      child: WillPopScope(
        onWillPop: _onWillPop,
        child: Scaffold(
          appBar: (isLandscape(context))
              ? null
              : AppBar(
                  title: Text("View Lesson"),
                ),
          body: _loading
              ? Center(
                  child: CircularLoading(),
                )
              : StreamBuilder<Lesson?>(
                  stream: _getLessonStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          GestureDetector(
                            onTap: _onVideoTap,
                            child: BackgroundContainer(
                              child: Stack(
                                fit: StackFit.expand,
                                children: [
                                  ValueListenableBuilder<int>(
                                    valueListenable: _imageChangeNotifier,
                                    builder: (_, value, __) {
                                      return ImageContainer(
                                        imageUrl: _bloc.lesson!.images![value],
                                      );
                                    },
                                  ),
                                  Container(
                                    key: _paintKey,
                                    child: PainterWidget(
                                      paintController,
                                    ),
                                  ),
                                  VideoControlsContainer(
                                    elapsedTimeNotifier: elapsedTimeNotifier,
                                    fullScreenTap: onFullScreenClick,
                                    onPauseTap: onPauseVideo,
                                    onResumeTap: onResumeTap,
                                    showVideoControls:
                                        _showVideoControls && _isVideoPlaying,
                                  ),
                                  VideoPlayContainer(
                                    isVideoPlaying: _isVideoPlaying,
                                    onTap: _onStartTap,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          if (!isLandscape(context))
                            ValueListenableBuilder<int>(
                              valueListenable: elapsedTimeNotifier,
                              builder: (_, value, __) {
                                return IgnorePointer(
                                  ignoring: true,
                                  child: Stack(
                                    alignment: Alignment.centerLeft,
                                    children: [
                                      Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.blue[50],
                                        ),
                                        width:
                                            MediaQuery.of(context).size.width,
                                      ),
                                      Container(
                                        height: 4,
                                        decoration: BoxDecoration(
                                          color: Colors.lightBlue,
                                          borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(2),
                                            bottomRight: Radius.circular(2),
                                          ),
                                        ),
                                        alignment: Alignment.centerLeft,
                                        width: MediaQuery.of(context)
                                                .size
                                                .width *
                                            (value / _bloc.lesson!.duration!),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          if (!isLandscape(context))
                            Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 16,
                                    vertical: 8,
                                  ),
                                  title: Text("${_bloc.lesson!.name}"),
                                  subtitle:
                                      Text("${_bloc.lesson!.description}"),
                                ),
                                SectionDivider(),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FlatButton.icon(
                                      onPressed: () {
                                        _onUpvoteClick(_bloc.lesson!);
                                      },
                                      icon: Icon(
                                        Icons.arrow_circle_up_rounded,
                                        color: _isLiked(snapshot.data!)
                                            ? null
                                            : Colors.black54,
                                      ),
                                      label: Text(
                                        'UPVOTE (${snapshot.data!.upvotes?.length ?? 0})',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: _isLiked(snapshot.data!)
                                              ? null
                                              : Colors.black54,
                                        ),
                                      ),
                                    ),
                                    FlatButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.mode_comment_outlined,
                                        color: Colors.black54,
                                      ),
                                      label: Text(
                                        'COMMENT (0)',
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Colors.black54,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                SectionDivider(),
                                SectionHeader('ALL COMMENTS'),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'No comments yet',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                                SectionDivider(),
                                SectionHeader('ALL RATINGS'),
                                Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Text(
                                    'No reviews yet',
                                    style: TextStyle(
                                      fontStyle: FontStyle.italic,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                        ],
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text(snapshot.error as String),
                      );
                    } else {
                      return Center(
                        child: CircularLoading(),
                      );
                    }
                  }),
        ),
      ),
    );
  }

  bool isLandscape(BuildContext context) {
    return MediaQuery.of(context).orientation == Orientation.landscape;
  }

  Future<void> _onStop() async {
    try {
      if (mounted) {
        // We need to call setState to refresh state to show play btn again
        setState(() {
          // Hide video controls if showing
          _showVideoControls = false;
        });
        _resetScreenToPotrait();
      }
      await audioPlayer.stop();
    } catch (e, s) {
      logger.e(e, s);
    }
  }

  Future<void> _startVideo({required double elapsedTime}) async {
    _bloc.lastEventTime = elapsedTime.toInt();
    eventList = _bloc.getNextList(_bloc.lastEventTime);

    final tempList = _bloc.getBeforeList(_bloc.lastEventTime);

    final lastImageChangeEvent = tempList.lastWhereOrNull(
      (element) => element.event == Events.changeImage,
    );

    final lastMoveEvent = tempList.lastWhereOrNull(
      (element) => element.event == Events.pointerMove,
    );

    final lastEndEvent = tempList.lastWhereOrNull(
      (element) => element.event == Events.pointerMove,
    );

    _imageChangeNotifier.value = lastImageChangeEvent?.index ?? 0;
    elapsedTimeNotifier.value = elapsedTime.toInt();

    setState(() {
      countDownTimer?.cancel();
      if (lastMoveEvent != null) {
        final pointerStartEvent = lastMoveEvent.copyWith(
          event: Events.pointerStart,
        );
        _onEvent(pointerStartEvent, _getHeight(), _getWidth());
      }
    });

    countDownTimer = MyCountdownTimer(
      Duration(
        milliseconds: _bloc.lesson!.duration!,
      ),
      Duration(milliseconds: 1),
      elapsedTime: Duration(
        milliseconds: elapsedTime.toInt(),
      ),
    );

    countDownTimer!.listen((event) {
      if (mounted) {
        elapsedTimeNotifier.value =
            _bloc.lesson!.duration! - event.remaining.inMilliseconds;

        _onTick(event.elapsed);
        if (event.remaining.inMilliseconds <
            Duration(milliseconds: 20).inMilliseconds) {
          _imageChangeNotifier.value = 0;
          paintController.clear();
          _onStop();
        }
      }
    });
    await audioPlayer.play(_bloc.audioPath, isLocal: true);

    await audioPlayer.seek(Duration(milliseconds: elapsedTime.toInt()));
  }

  void _onTick(Duration elapsed) {
    if (eventList.isEmpty) {
      eventList = _bloc.getNextList(_bloc.lastEventTime);
    }

    final rawEvents = eventList
        .where((element) =>
            (elapsed.inMilliseconds - 25 < element.time) &&
            (element.time < elapsed.inMilliseconds + 25))
        .toList(growable: false);
    // ignore: avoid_function_literals_in_foreach_calls, cascade_invocations
    rawEvents.forEach((event) {
      _onEvent(event, _getHeight(), _getWidth());
      eventList.remove(event);
    });
    _bloc.lastEventTime = elapsed.inMilliseconds;
  }

  void _onVideoTap() {
    if (_isVideoPlaying) {
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
  }

  void onPauseVideo() {
    _pauseDuration = countDownTimer!.elapsedTime ?? Duration(milliseconds: 0);
    audioPlayer.pause();
    countDownTimer?.cancel();
  }

  void _onEvent(MyEvent event, double height, double width) {
    if (event.event == Events.changeImage) {
      paintController.clear();
      _imageChangeNotifier.value = event.index!;
    } else if (event.event == Events.pointerStart) {
      paintController.onPointerStart(event.x! * width, event.y! * height);
    } else if (event.event == Events.pointerMove) {
      paintController.onPointerMove(event.x! * width, event.y! * height);
    } else if (event.event == Events.pointerEnd) {
      paintController.onPointerEnd();
    }
  }

  void _onStartTap() {
    _startVideo(
      elapsedTime: _pauseDuration.inMilliseconds.toDouble(),
    );
    _pauseDuration = Duration(
      milliseconds: 0,
    );
  }

  void onResumeTap(double? value) {
    _startVideo(
      elapsedTime: value ?? 0,
    );
  }

  void onFullScreenClick() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
      SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    } else {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeLeft]);
      SystemChrome.setEnabledSystemUIOverlays([]);
    }
  }

  void _resetScreenToPotrait() {
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
  }

  Future<bool> _onWillPop() {
    if (MediaQuery.of(context).orientation == Orientation.landscape) {
      onFullScreenClick();
      return Future.value(false);
    }
    return Future.value(true);
  }

  @override
  void dispose() {
    _bloc.dispose();
    countDownTimer?.cancel();
    audioPlayer
      ..stop()
      ..dispose();
    super.dispose();
  }

  double _getHeight() {
    final box = _paintKey.currentContext!.findRenderObject() as RenderBox;
    return box.size.height;
  }

  double _getWidth() {
    final box = _paintKey.currentContext!.findRenderObject() as RenderBox;
    return box.size.width;
  }

  void _onUpvoteClick(Lesson lesson) {
    final userId = locator<UserRepository>().getLoggedInUser()!.id;

    var upvotes = lesson.upvotes ?? [];

    final isLiked = _isLiked(lesson);
    if (isLiked) {
      upvotes = upvotes
        ..remove(userId)
        ..toSet().toList(growable: false);
    } else {
      upvotes = upvotes
        ..add(userId)
        ..toSet().toList(growable: false);
    }
    FirebaseFirestore.instance
        .collection('lessons')
        .doc(widget.lessonId)
        .update({'upvotes': upvotes});
  }

  Stream<Lesson?> _getLessonStream() {
    return FirebaseFirestore.instance
        .collection('lessons')
        .doc(widget.lessonId)
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (data, sink) {
      return sink.add(Lesson.fromJson(data.data()!).copyWith(id: data.id));
    }));
  }

  _isLiked(Lesson lesson) {
    final userId = locator<UserRepository>().getLoggedInUser()!.id;
    return (lesson.upvotes ?? []).contains(userId);
  }
}
