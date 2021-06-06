import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';
import 'package:flutter_record_lesson/data/local/app_db.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/src/bloc/record_lesson_bloc.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/my_app_bar.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/ready_widget.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/stop_button.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/timer_widget.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:flutter_record_lesson/utils/toast_utils.dart';
import 'package:flutter_sound_lite/flutter_sound.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_platform_interface.dart';
import 'package:flutter_sound_platform_interface/flutter_sound_recorder_platform_interface.dart';
import 'package:lottie/lottie.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:quiver/async.dart';

import '../models/my_event.dart';
import 'blocs/record_lesson_bloc.dart';
import 'painter_controller.dart';
import 'publish_lesson_page.dart';
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
  final _bloc = Bloc();
  FlutterSoundRecorder? myRecorder;
  late File audioFile;
  int pageIndex = 0;
  bool _preparingRecord = false;

  StreamSubscription<CountdownTimer>? countDownSubs;

  bool get showPreviousBtn => _bloc.isRecording && pageIndex > 0;

  bool get showNextBtn =>
      _bloc.isRecording && pageIndex < _bloc.imageList.length - 1;

  double get getPreviousBtnOpacity => showPreviousBtn ? 1 : 0;

  double get getNextBtnOpacity => showNextBtn ? 1 : 0;

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
                child: PainterWidget(
                  _bloc.paintController,
                  () {},
                ),
              ),
            if (showPreviousBtn)
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
            if (showNextBtn)
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
                child: PauseButton(
                  onTap: _onStopRecord,
                ),
              ),
            if (_bloc.isRecording)
              Positioned(
                left: 4,
                child: Column(
                  children: [
                    ...Bloc.kPointerColors.map(
                      (e) => Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => _bloc.onPointerColorChange(e),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: Bloc.kPointerDotSize,
                              width: Bloc.kPointerDotSize,
                              decoration: BoxDecoration(
                                color: e.withOpacity(0.9),
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
              IgnorePointer(
                child: Container(
                  color: Colors.black.withOpacity(0.78),
                  alignment: Alignment.center,
                  child: Lottie.asset(
                    'assets/lottie/15012-tiktok-3-sec-countdown.json',
                    height: 56,
                    repeat: false,
                  ),
                ),
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

      final currentLesson = locator<RecordingLessonBloc>().currentLesson;
      final updatedLesson = currentLesson.copyWith(
        events: _bloc.eventList,
        duration: DateTime.now().millisecondsSinceEpoch - _bloc.startEpoch,
        rawImagePaths: _bloc.imageList.map((e) => e.path).toList(
              growable: false,
            ),
        audioPath: audioFile.path,
      );

      await locator<AppDb>().saveRawLesson(updatedLesson);
      _openNextPage(updatedLesson);
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
      toFile: audioFile.path,
      codec: Codec.aacADTS,
      audioSource: AudioSource.defaultSource,
    );

    _bloc.countDownTimer = CountdownTimer(
      Duration(seconds: LessonConstants.totalSeconds),
      Duration(seconds: 1),
    );

    countDownSubs = _bloc.countDownTimer!.listen((event) {
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
      audioFile = File('${tempDir.path}/flutter_sound-tmp.aac');

      // Request Microphone permission if needed
      final status = await Permission.microphone.request();
      if (status != PermissionStatus.granted) {
        throw RecordingPermissionException("Microphone permission not granted");
      }
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

  @override
  void dispose() {
    countDownSubs?.cancel();
    _bloc.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }

  void _openNextPage(Lesson updatedLesson) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (_) => PublishLessonPage(lesson: updatedLesson),
      ),
    );
  }
}
