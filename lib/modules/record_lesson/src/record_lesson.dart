import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_sound/flutter_sound.dart' as r;
import 'package:flutter_sound/flutter_sound.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
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

  CountdownTimer countDownTimer;

  int _totalSeconds = 15 * 60;

  Duration remainingDuration;

  double _kHeight = 300;
  double _kWidth = 300;

  int startEpoch;

  final _paintKey = GlobalKey();

  r.FlutterSoundRecorder myRecorder;

  File outputFile;

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
      body: Container(
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
                        imageUrl: _imageList[_pageIndex],
                        placeholder: (context, url) =>
                            Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      if (countDownTimer?.isRunning ?? false)
                        Container(
                          key: _paintKey,
                          child: Painter(
                            _paintController,
                            () {},
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  RaisedButton(
                    onPressed: _pageIndex > 0
                        ? () {
                            setState(() {
                              _pageIndex--;
                            });
                            _addEvent(
                                name: Events.changeImage, index: _pageIndex);
                          }
                        : null,
                    child: Text("PREVIOUS"),
                  ),
                  RaisedButton(
                    onPressed: (_pageIndex < _imageList.length - 1)
                        ? () {
                            setState(() {
                              _pageIndex++;
                            });
                            _addEvent(
                                name: Events.changeImage, index: _pageIndex);
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
              Text(remainingDuration.toString().split('.')[0].padLeft(8, '0')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (countDownTimer == null || !countDownTimer.isRunning)
                  RaisedButton(
                    onPressed: () {
                      _startRecord();
                    },
                    child: Text("START"),
                  )
                else
                  RaisedButton(
                    onPressed: countDownTimer?.isRunning ?? false
                        ? () async {
                            setState(() {
                              countDownTimer.cancel();
                              _paintController.clear();
                            });
                            await myRecorder.stopRecorder();
                            if (myRecorder != null) {
                              myRecorder.closeAudioSession();
                              myRecorder = null;
                            }
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
          ],
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
    RenderBox box = _paintKey.currentContext.findRenderObject();
    final height = box.size.height;
    final width = box.size.width;
    _eventList.add(
      MyEvent(
        event: name,
        index: index,
        time: DateTime.now().millisecondsSinceEpoch - startEpoch,
        x: double.parse(((x ?? 0) / width).toStringAsFixed(6)),
        y: double.parse(((y ?? 0) / height).toStringAsFixed(6)),
      ),
    );
  }

  Future<void> _onComplete() async {
    try {
      final lessonRef = FirebaseFirestore.instance.collection('lessons').doc();
      final lesson = Lesson(
        events: _eventList,
        duration: DateTime.now().millisecondsSinceEpoch - startEpoch,
        id: lessonRef.id,
        name: "Sample Title",
        description: "Sample description of the video",
        images: _imageList,
      );
      final map = Lesson(events: _eventList, id: lessonRef.id).toJson();
      final jsonString = jsonEncode(map);

      /// MP3 audio
      final storageReference1 =
          FirebaseStorage().ref().child('lessons/${lessonRef.id}/audio.aac');
      final uploadTask1 = storageReference1.putFile(
          outputFile, StorageMetadata(contentType: 'audio/aac'));
      await uploadTask1.onComplete;
      final audioUrl = await storageReference1.getDownloadURL();
      print(audioUrl);

      /// Events
      final storageReference =
          FirebaseStorage().ref().child('lessons/${lessonRef.id}/events.json');
      final uploadTask = storageReference.putData(utf8.encode(jsonString),
          StorageMetadata(contentType: 'application/json'));
      await uploadTask.onComplete;
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

  void _startRecord() async {
    myRecorder = await r.FlutterSoundRecorder().openAudioSession();

    startEpoch = DateTime.now().millisecondsSinceEpoch;

    setState(() {
      this.remainingDuration = Duration(seconds: _totalSeconds);
    });
    final tempDir = await getTemporaryDirectory();
    outputFile = File('${tempDir.path}/flutter_sound-tmp.aac');

    // Request Microphone permission if needed
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted)
      throw RecordingPermissionException("Microphone permission not granted");

    await myRecorder.startRecorder(
      toFile: outputFile.path,
      codec: r.Codec.aacADTS,
      audioSource: r.AudioSource.defaultSource,
    );

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
  }
}
