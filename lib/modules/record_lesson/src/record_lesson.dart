import 'dart:convert';
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';
import 'package:flutter_record_lesson/core/extensions/color_extension.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
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
  int _pageIndex = 0;
  final _imageList = [
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_2.jpeg",
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_4.jpeg",
    "https://storage.googleapis.com/teaching-6b309.appspot.com/Physics/Rotational%20Mechanics/0NGIMFPU254QUVDPFA5C/0NGIMFPU254QUVDPFA5C%20solution_5.jpeg",
  ];

  final _eventList = <MyEvent>[];

  PainterController _paintController;

  CountdownTimer countDownTimer;

  int startEpoch;

  final _paintKey = GlobalKey();

  FlutterSoundRecorder myRecorder;

  File outputFile;

  get _isRecording => countDownTimer?.isRunning ?? false;

  final remainingDurationNotifier = ValueNotifier<Duration>(
    Duration(seconds: LessonConstants.totalSeconds),
  );

  @override
  void initState() {
    super.initState();
    _initPaintController();
  }

  void _initPaintController() {
    _paintController = PainterController(
      backgroundColor: Colors.transparent,
      drawColor: Colors.greenAccent.withOpacity(0.4),
      thickness: 24,
      startMotion: (x, y) {
        _addEvent(name: Events.pointerStart, x: x, y: y);
      },
      moveMotion: (x, y) {
        _addEvent(name: Events.pointerMove, x: x, y: y);
      },
      endMotion: () {
        _addEvent(name: Events.pointerEnd);
      },
    );
  }

  void _setPointerColor(Color color) {
    _paintController.setPointerColor(color);
    _addEvent(name: Events.pointerColor, color: Colors.blue.withOpacity(0.4));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Record Lesson'),
      ),
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
            if (_isRecording)
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
            if (_isRecording)
              ValueListenableBuilder<Duration>(
                valueListenable: remainingDurationNotifier,
                builder: (context, value, child) {
                  return Text(value.toString().split('.')[0].padLeft(8, '0'));
                },
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (!_isRecording)
                  RaisedButton(
                    onPressed: () {
                      _startRecord();
                    },
                    child: Text("START"),
                  )
                else
                  RaisedButton(
                    onPressed: () async {
                      _onStopRecord();
                    },
                    child: Text("STOP"),
                  ),
              ],
            ),
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
    Color color,
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
        color: color.hexCode(),
      ),
    );
  }

  Future<void> _onStopRecord() async {
    try {
      setState(() {
        countDownTimer.cancel();
        _paintController.clear();
      });
      await myRecorder.stopRecorder();
      if (myRecorder != null) {
        myRecorder.closeAudioSession();
        myRecorder = null;
      }

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
      await storageReference1.putFile(
          outputFile, SettableMetadata(contentType: 'audio/aac'));

      final audioUrl = await storageReference1.getDownloadURL();
      print(audioUrl);

      /// Events
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('lessons/${lessonRef.id}/events.json');
      await storageReference.putData(utf8.encode(jsonString),
          SettableMetadata(contentType: 'application/json'));
      final jsonUrl = await storageReference.getDownloadURL();
      print(jsonUrl);

      await lessonRef.set({
        ...lesson.copyWith(events: null).toJson(),
      }, SetOptions(merge: true));

      print('Lesson Uploaded');
    } catch (e, s) {
      print(e);
    }
  }

  void _startRecord() async {
    myRecorder = await FlutterSoundRecorder().openAudioSession();

    startEpoch = DateTime.now().millisecondsSinceEpoch;
    remainingDurationNotifier.value =
        Duration(seconds: LessonConstants.totalSeconds);
    final tempDir = await getTemporaryDirectory();
    outputFile = File('${tempDir.path}/flutter_sound-tmp.aac');

    // Request Microphone permission if needed
    final status = await Permission.microphone.request();
    if (status != PermissionStatus.granted)
      throw RecordingPermissionException("Microphone permission not granted");

    await myRecorder.startRecorder(
      toFile: outputFile.path,
      codec: Codec.aacADTS,
      audioSource: AudioSource.defaultSource,
    );

    countDownTimer = new CountdownTimer(
      Duration(seconds: LessonConstants.totalSeconds),
      Duration(seconds: 1),
    );
    countDownTimer.listen((event) {
      remainingDurationNotifier.value = event.remaining;
    });
  }

  void reset() {
    setState(() {
      remainingDurationNotifier.value =
          Duration(seconds: LessonConstants.totalSeconds);
      countDownTimer?.cancel();
      countDownTimer = null;
      _paintController.clear();
      myRecorder = null;
    });
  }
}
