import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/my_app_bar.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/ready_widget.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/stop_button.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/timer_widget.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:flutter_record_lesson/utils/toast_utils.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiver/async.dart';

import '../models/my_event.dart';
import 'blocs/record_lesson_bloc.dart';
import 'painter_controller.dart';
import 'widgets/fade_screen.dart';
import 'widgets/image_controller_button.dart';

class RecordLessonPage extends StatefulWidget {
  @override
  _RecordLessonPageState createState() => _RecordLessonPageState();

  RecordLessonPage({
    required this.images,
  });

  final List<String> images;
}

class _RecordLessonPageState extends State<RecordLessonPage> {
  final _bloc = RecordLessonBloc();
  FlutterSoundRecorder? myRecorder;
  late File outputFile;
  int pageIndex = 0;
  bool _preparingRecord = false;

  double get getPreviousBtnOpacity =>
      (_bloc.isRecording && pageIndex > 0) ? 1 : 0;

  double get getNextBtnOpacity =>
      (_bloc.isRecording && pageIndex < _bloc.imageList.length - 1) ? 1 : 0;

  File get getCurrentImage => _bloc.imageList[pageIndex];

  @override
  void initState() {
    super.initState();
    _initScreenRequirements();
    _bloc
      ..addImages(widget.images)
      ..initPaintController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Stack(
          fit: StackFit.expand,
          alignment: Alignment.center,
          children: [
            Image.file(
              getCurrentImage,
              // imageUrl: _imageList[_pageIndex],
              // placeholder: (context, url) =>
              //     Center(child: CircularLoading()),
              // errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            if (_bloc.isRecording)
              Container(
                key: _bloc.paintKey,
                child: Painter(
                  _bloc.paintController,
                  () {},
                ),
              ),
            Positioned(
              left: 16,
              bottom: 8,
              child: Transform.rotate(
                angle: 3.14,
                child: ImageControllerButton(
                  opacity: getPreviousBtnOpacity,
                  onTap: _onPreviousImageTap,
                  icon: Icon(
                    Icons.double_arrow,
                  ),
                ),
              ),
            ),
            Positioned(
              right: 16,
              bottom: 8,
              child: ImageControllerButton(
                opacity: getNextBtnOpacity,
                onTap: _onNextImageTap,
                icon: Icon(
                  Icons.double_arrow,
                ),
              ),
            ),
            if (_bloc.isRecording)
              Positioned(
                right: 16,
                top: 12,
                child: TimerWidget(
                  notifier: _bloc.remainingDurationNotifier,
                ),
              ),
            if (_bloc.isRecording)
              Positioned(
                top: 6,
                left: 16,
                child: StopButton(
                  onTap: _onStopRecord,
                ),
              ),
            if (_bloc.isRecording)
              Positioned(
                left: 4,
                child: Column(
                  children: [
                    ...RecordLessonBloc.kPointerColors.map(
                      (e) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _bloc.onPointerColorChange(e),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: RecordLessonBloc.kPointerDotSize,
                              width: RecordLessonBloc.kPointerDotSize,
                              decoration: BoxDecoration(
                                color: e.withOpacity(0.5),
                                shape: BoxShape.rectangle,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            if (_preparingRecord)
              Container(
                color: Colors.black.withOpacity(0.78),
                child: Lottie.asset(
                  'assets/lottie/15012-tiktok-3-sec-countdown.json',
                  height: 56,
                  repeat: false,
                ),
                alignment: Alignment.center,
              ),
            if (_bloc.isNotRecording && !_preparingRecord) FadeScreen(),
            if (_bloc.isNotRecording && !_preparingRecord)
              ReadyWidget(onTap: _prepareAndStartRecord),
            if (_bloc.isNotRecording && !_preparingRecord) MyAppBar(),
          ],
        ),
      ),
    );
  }

  Future<void> _onStopRecord() async {
    try {
      setState(() {
        _bloc.countDownTimer!.cancel();
        _bloc.paintController!.clear();
      });
      await myRecorder!.stopRecorder();
      if (myRecorder != null) {
        await myRecorder!.closeAudioSession();
        myRecorder = null;
      }
      // final currentLesson = injector<RecordLessonBloc>().currentLesson;
      // final _uploadedImages = <String>[];
      // for (var i = 0; i < _imageList.length; i++) {
      //   final storageReference = FirebaseStorage.instance
      //       .ref()
      //       .child('lessons/${currentLesson.id}/$i.jpg');
      //   await storageReference.putFile(_imageList.elementAt(i),
      //       SettableMetadata(contentType: 'image/jpeg'));
      //   final imageUrl = await storageReference.getDownloadURL();
      //   _uploadedImages.add(imageUrl);
      // }
      //
      // final lesson = currentLesson.copyWith(
      //   events: _eventList,
      //   duration: DateTime.now().millisecondsSinceEpoch - startEpoch,
      //   images: _uploadedImages,
      // );
      // final jsonString = jsonEncode(lesson.toJson());
      //
      // /// MP3 audio
      // final storageReference1 = FirebaseStorage.instance
      //     .ref()
      //     .child('lessons/${lesson.id}/audio.aac');
      // await storageReference1.putFile(
      //     outputFile, SettableMetadata(contentType: 'audio/aac'));
      //
      // final audioUrl = await storageReference1.getDownloadURL();
      // print(audioUrl);
      //
      // /// Events
      // final storageReference = FirebaseStorage.instance
      //     .ref()
      //     .child('lessons/${lesson.id}/events.json');
      // await storageReference.putData(utf8.encode(jsonString) as Uint8List,
      //     SettableMetadata(contentType: 'application/json'));
      // final jsonUrl = await storageReference.getDownloadURL();
      // print(jsonUrl);
      //
      // final lessonRef =
      //     FirebaseFirestore.instance.collection('lessons').doc(lesson.id);
      //
      // await lessonRef.set({
      //   ...lesson.copyWith().toJson(),
      // }, SetOptions(merge: true));

      logger.i('Lesson Uploaded');
    } catch (e, s) {
      logger.e(e, s);
    }
  }

  Future<void> _prepareAndStartRecord() async {
    try {
      setState(() {
        _preparingRecord = true;
      });
      await Future.wait([
        prepareRecording(),
        Future.delayed(Duration(milliseconds: 2500)),
      ]);
      await _startRecorder();
    } catch (e, s) {
      logger.e(e, s);
      ToastUtils.show(e.toString());
    } finally {
      setState(() {
        _preparingRecord = false;
      });
    }
  }

  Future<void> _startRecorder() async {
    await myRecorder!.startRecorder(
      toFile: outputFile.path,
      codec: Codec.aacADTS,
      audioSource: AudioSource.defaultSource,
    );

    _bloc.countDownTimer = new CountdownTimer(
      Duration(seconds: LessonConstants.totalSeconds),
      Duration(seconds: 1),
    );
    _bloc.countDownTimer!.listen((event) {
      setState(() {
        _bloc.remainingDurationNotifier.value = event.remaining;
      });
    });
  }

  Future<void> prepareRecording() async {
    try {
      myRecorder = await FlutterSoundRecorder().openAudioSession();

      _bloc.startEpoch = DateTime.now().millisecondsSinceEpoch;
      _bloc.remainingDurationNotifier.value = Duration(
        seconds: LessonConstants.totalSeconds,
      );
      final tempDir = await getTemporaryDirectory();
      outputFile = File('${tempDir.path}/flutter_sound-tmp.aac');

      // Request Microphone permission if needed
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted)
        throw RecordingPermissionException("Microphone permission not granted");
    } catch (e, s) {
      logger.e(e, s);

      rethrow;
    }
  }

  void reset() {
    setState(() {
      _bloc.reset();
      myRecorder = null;
    });
  }

  @override
  void dispose() {
    _bloc.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void _onPreviousImageTap() {
    setState(() {
      pageIndex--;
    });
    _bloc.addEvent(
      name: Events.changeImage,
      index: pageIndex,
    );
  }

  void _onNextImageTap() {
    setState(() {
      pageIndex++;
    });
    _bloc.addEvent(
      name: Events.changeImage,
      index: pageIndex,
    );
  }

  void _initScreenRequirements() {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);
    SystemChrome.setEnabledSystemUIOverlays([]);
  }
}
