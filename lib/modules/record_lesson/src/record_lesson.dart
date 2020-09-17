import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/play_lesson/play_lesson_page.dart';
import 'package:quiver/async.dart';

import '../models/my_event.dart';
import 'painter_controller.dart';

class RecordLessonPage extends StatefulWidget {
  @override
  _RecordLessonPageState createState() => _RecordLessonPageState();
}

class _RecordLessonPageState extends State<RecordLessonPage> {
  final _imageController = PageController();
  int _pageIndex = 0;
  final _imageList = [
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_2.jpeg",
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_4.jpeg",
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_5.jpeg",
  ];

  final _eventList = <MyEvent>[];

  PainterController _paintController;
  bool isCanvasEmpty = true;
  final int startEpoch = DateTime.now().millisecondsSinceEpoch;

  CountdownTimer countDownTimer;

  int _totalSeconds = 15 * 60;

  Duration remainingDuration;

  double _kHeight = 300;
  double _kWidth = 300;

  @override
  void initState() {
    super.initState();
    _paintController = PainterController(
      backgroundColor: Colors.transparent,
      drawColor: Colors.greenAccent.withOpacity(0.4),
      thickness: 28,
      startMotion: (x, y) {
        print('Start: $x,$y');
        _addEvent(name: Events.pointerStart, x: x, y: y);
      },
      moveMotion: (x, y) {
        print('Move: $x,$y');
        _addEvent(name: Events.pointerMove, x: x, y: y);
      },
      endMotion: () {
        print('End');
        _addEvent(
          name: Events.pointerEnd,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    _kHeight = MediaQuery.of(context).size.height / 3;
    _kWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text("Record Lesson"),
      ),
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                color: Colors.black87,
                height: _kHeight,
                width: _kWidth,
                child: Stack(
                  children: [
                    PageView(
                      physics: NeverScrollableScrollPhysics(),
                      controller: _imageController,
                      onPageChanged: (val) {
                        setState(() {
                          _pageIndex = val;
                        });
                        _addEvent(name: Events.changeImage, index: val);
                        _paintController?.clear();
                      },
                      scrollDirection: Axis.horizontal,
                      children: [
                        ..._imageList.map(
                          (e) => CachedNetworkImage(
                            imageUrl: e,
                            placeholder: (context, url) =>
                                Center(child: CircularProgressIndicator()),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ],
                    ),
                    if (countDownTimer?.isRunning ?? false)
                      Painter(_paintController, () {}),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              if (countDownTimer?.isRunning ?? false)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    RaisedButton(
                      onPressed: _pageIndex > 0
                          ? () {
                              _pageIndex--;
                              _imageController.jumpToPage(_pageIndex);
                            }
                          : null,
                      child: Text("PREVIOUS"),
                    ),
                    RaisedButton(
                      onPressed: (_pageIndex < _imageList.length - 1)
                          ? () {
                              _pageIndex++;
                              _imageController.jumpToPage(_pageIndex);
                            }
                          : null,
                      child: Text("NEXT"),
                    )
                  ],
                ),
              SizedBox(
                height: 16,
              ),
              if (countDownTimer?.isRunning ?? false)
                Text(
                    remainingDuration.toString().split('.')[0].padLeft(8, '0')),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  if (countDownTimer == null || !countDownTimer.isRunning)
                    RaisedButton(
                      onPressed: () {
                        setState(() {
                          this.remainingDuration =
                              Duration(seconds: _totalSeconds);
                        });

                        countDownTimer = new CountdownTimer(
                          Duration(seconds: _totalSeconds),
                          Duration(seconds: 1),
                        );
                        countDownTimer.listen((event) {
                          if (mounted)
                            setState(() {
                              this.remainingDuration = event.remaining;
                            });
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
              SizedBox(
                height: 16,
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => PlayLessonPage()));
                },
                child: Text("Play Video"),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _addEvent({
    Events name,
    int index,
    double x,
    double y,
  }) {
    _eventList.add(
      MyEvent(
        event: name,
        index: index,
        time: DateTime.now().millisecondsSinceEpoch - startEpoch,
        x: double.parse(((x ?? 0) / _kWidth).toStringAsFixed(4)),
        y: double.parse(((y ?? 0) / _kHeight).toStringAsFixed(4)),
      ),
    );
  }

  Future<void> _onComplete() async {
    try {
      final lessonRef = FirebaseFirestore.instance.collection('lessons').doc();
      final lesson = Lesson(
        events: _eventList,
        duration: _totalSeconds * 1000 - remainingDuration.inMilliseconds,
        id: lessonRef.id,
        name: "Sample Title",
        description: "Sample description of the video",
        images: _imageList,
      );
      final map = Lesson(events: _eventList, id: lessonRef.id).toJson();
      final jsonString = jsonEncode(map);
      final StorageReference storageReference =
          FirebaseStorage().ref().child('lessons/${lessonRef.id}/events.json');
      final uploadTask = storageReference.putData(utf8.encode(jsonString),
          StorageMetadata(contentType: 'application/json'));
      await uploadTask.onComplete;
      // logger.d('File Uploaded');
      final jsonUrl = await storageReference.getDownloadURL();
      print(jsonUrl);
      await lessonRef.set({
        ...lesson
            .copyWith(
              events: null,
            )
            .toJson(),
      }, SetOptions(merge: true));
      print('Lesson Uploaded');
    } catch (e, s) {
      print(e);
    }
  }
}
