import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/painter_controller.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:quiver/async.dart';

class PlayLessonPage extends StatefulWidget {
  @override
  _PlayLessonPageState createState() => _PlayLessonPageState();
}

class _PlayLessonPageState extends State<PlayLessonPage> {
  final lessonId = '5oSAKfuRgqDtdLwl3TxN';
  final _imageController = PageController();

  PainterController _paintController;

  CountdownTimer countDownTimer;

  Duration remainingDuration;

  Lesson lesson;

  int _imageIndex = 0;

  final _paintKey = GlobalKey();

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
      appBar: AppBar(
        title: Text("Record Lesson"),
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
                        maxHeight: 500,
                        maxWidth: 500,
                      ),
                      child: Container(
                        color: Colors.black87,
                        child: IntrinsicHeight(
                          child: Stack(
                            children: [
                              CachedNetworkImage(
                                imageUrl: lesson.images[_imageIndex],
                                placeholder: (context, url) =>
                                    Center(child: CircularProgressIndicator()),
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
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 16,
                    ),
                    if (countDownTimer?.isRunning ?? false)
                      Text(remainingDuration
                          .toString()
                          .split('.')[0]
                          .padLeft(8, '0')),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        if (countDownTimer == null || !countDownTimer.isRunning)
                          RaisedButton(
                            onPressed: () {
                              setState(() {
                                _imageIndex = 0;
                                countDownTimer?.cancel();
                                _paintController.clear();

                                this.remainingDuration =
                                    Duration(milliseconds: lesson.duration);
                              });

                              countDownTimer = new CountdownTimer(
                                Duration(milliseconds: lesson.duration),
                                Duration(milliseconds: 1),
                              );
                              countDownTimer.listen((event) {
                                if (mounted) {
                                  setState(() {
                                    this.remainingDuration = event.remaining;
                                  });
                                  _onTick(event.elapsed);
                                  if (event.remaining.inMilliseconds <
                                      Duration(milliseconds: 50)
                                          .inMilliseconds) {
                                    _imageIndex = 0;
                                    _paintController.clear();
                                  }
                                }
                              });
                            },
                            child: Text("START"),
                          )
                        else
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
        FirebaseStorage().ref().child('lessons/$lessonId/events.json');
    var directory = await getTemporaryDirectory();
    final path = p.join(directory.path, '$lessonId/events.json');
    final file = File(path);
    final task = storageReference.writeToFile(file);
    await task.future;
    final events =
        ((jsonDecode(file.readAsStringSync()) as Map)['events'] as List)
            .map((e) => MyEvent.fromJson(e))
            .cast<MyEvent>()
            .toList();
    final doc = await FirebaseFirestore.instance.doc('lessons/$lessonId').get();
    setState(() {
      lesson = Lesson.fromJson(doc.data()).copyWith(id: doc.id, events: events);
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

    final event = lesson.events.firstWhere(
        (element) => element.time == elapsed.inMilliseconds,
        orElse: () => null);
    if (event != null) {
      print(elapsed.inMilliseconds);
      print(event.event.getName());

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
    }
  }
}
