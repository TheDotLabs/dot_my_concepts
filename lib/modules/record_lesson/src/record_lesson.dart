import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';
import 'package:flutter_record_lesson/core/extensions/color_extension.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/src/bloc/record_lesson_bloc.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:flutter_record_lesson/utils/toast_utils.dart';
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

  RecordLessonPage({this.images});

  final List<String>? images;
}

class _RecordLessonPageState extends State<RecordLessonPage> {
  int _pageIndex = 0;
  List<File> _imageList = <File>[];

  final _eventList = <MyEvent>[];

  PainterController? _paintController;

  CountdownTimer? countDownTimer;

  late int startEpoch;

  final _paintKey = GlobalKey();

  FlutterSoundRecorder? myRecorder;

  late File outputFile;

  get _isRecording => countDownTimer?.isRunning ?? false;

  final remainingDurationNotifier = ValueNotifier<Duration>(
    Duration(seconds: LessonConstants.totalSeconds),
  );

  @override
  void initState() {
    super.initState();
    _imageList
        .addAll(widget.images!.map((e) => File(e)).toList(growable: false));
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
    _paintController!.setPointerColor(color);
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
                      Image.file(
                        _imageList[_pageIndex],
                        // imageUrl: _imageList[_pageIndex],
                        // placeholder: (context, url) =>
                        //     Center(child: CircularLoading()),
                        // errorWidget: (context, url, error) => Icon(Icons.error),
                      ),
                      if (_isRecording)
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
    Events? name,
    int? index,
    double? x,
    double? y,
    Color? color,
  }) {
    RenderBox box = _paintKey.currentContext!.findRenderObject() as RenderBox;
    final height = box.size.height;
    final width = box.size.width;
    _eventList.add(
      MyEvent(
        event: name,
        index: index,
        time: DateTime.now().millisecondsSinceEpoch - startEpoch,
        x: double.parse(((x ?? 0) / width).toStringAsFixed(6)),
        y: double.parse(((y ?? 0) / height).toStringAsFixed(6)),
        color: color?.hexCode(),
      ),
    );
  }

  Future<void> _onStopRecord() async {
    try {
      setState(() {
        countDownTimer!.cancel();
        _paintController!.clear();
      });
      await myRecorder!.stopRecorder();
      if (myRecorder != null) {
        myRecorder!.closeAudioSession();
        myRecorder = null;
      }
      final currentLesson = injector<RecordLessonBloc>().currentLesson;
      final _uploadedImages = <String>[];
      for (var i = 0; i < _imageList.length; i++) {
        final storageReference = FirebaseStorage.instance
            .ref()
            .child('lessons/${currentLesson.id}/$i.jpg');
        await storageReference.putFile(_imageList.elementAt(i),
            SettableMetadata(contentType: 'image/jpeg'));
        final imageUrl = await storageReference.getDownloadURL();
        _uploadedImages.add(imageUrl);
      }

      final lesson = currentLesson.copyWith(
        events: _eventList,
        duration: DateTime.now().millisecondsSinceEpoch - startEpoch,
        images: _uploadedImages,
      );
      final jsonString = jsonEncode(lesson.toJson());

      /// MP3 audio
      final storageReference1 = FirebaseStorage.instance
          .ref()
          .child('lessons/${lesson.id}/audio.aac');
      await storageReference1.putFile(
          outputFile, SettableMetadata(contentType: 'audio/aac'));

      final audioUrl = await storageReference1.getDownloadURL();
      print(audioUrl);

      /// Events
      final storageReference = FirebaseStorage.instance
          .ref()
          .child('lessons/${lesson.id}/events.json');
      await storageReference.putData(utf8.encode(jsonString) as Uint8List,
          SettableMetadata(contentType: 'application/json'));
      final jsonUrl = await storageReference.getDownloadURL();
      print(jsonUrl);

      final lessonRef =
          FirebaseFirestore.instance.collection('lessons').doc(lesson.id);

      await lessonRef.set({
        ...lesson.copyWith().toJson(),
      }, SetOptions(merge: true));

      logger.i('Lesson Uploaded');
    } catch (e, s) {
      logger.e(e, s);
    }
  }

  Future<void> _startRecord() async {
    try {
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

      await myRecorder!.startRecorder(
        toFile: outputFile.path,
        codec: Codec.aacADTS,
        audioSource: AudioSource.defaultSource,
      );

      countDownTimer = new CountdownTimer(
        Duration(seconds: LessonConstants.totalSeconds),
        Duration(seconds: 1),
      );
      countDownTimer!.listen((event) {
        setState(() {
          remainingDurationNotifier.value = event.remaining;
        });
      });
    } catch (e, s) {
      logger.e(e, s);
      ToastUtils.show(e.toString());
    }
  }

  void reset() {
    setState(() {
      remainingDurationNotifier.value =
          Duration(seconds: LessonConstants.totalSeconds);
      countDownTimer?.cancel();
      countDownTimer = null;
      _paintController!.clear();
      myRecorder = null;
    });
  }
}
