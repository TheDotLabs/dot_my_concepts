import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';
import 'package:flutter_record_lesson/core/extensions/color_extension.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:quiver/async.dart';

import '../painter_controller.dart';

class Bloc extends BaseBloc {
  static const double kPointerDotSize = 20;
  static const double kPointerColorOpacity = 0.4;

  static const kPointerColors = <Color>[
    Colors.redAccent,
    Colors.greenAccent,
    Colors.yellowAccent,
    Colors.blueAccent,
  ];
  final paintKey = GlobalKey();

  final eventList = <MyEvent>[];
  late int startEpoch;
  List<File> imageList = <File>[];

  PainterController? paintController;

  CountdownTimer? countDownTimer;

  bool get isRecording => countDownTimer?.isRunning ?? false;

  bool get isNotRecording => !isRecording;

  final remainingDurationNotifier = ValueNotifier<Duration>(
    Duration(seconds: LessonConstants.totalSeconds),
  );

  void addImages(List<String> images) {
    imageList.addAll(
      images.map((e) => File(e)).toList(growable: false),
    );
  }

  void initPaintController() {
    paintController = PainterController(
      backgroundColor: Colors.transparent,
      drawColor: Colors.greenAccent.withOpacity(kPointerColorOpacity),
      thickness: 24,
      startMotion: (x, y) {
        addEvent(name: Events.pointerStart, x: x, y: y);
      },
      moveMotion: (x, y) {
        addEvent(name: Events.pointerMove, x: x, y: y);
      },
      endMotion: () {
        addEvent(name: Events.pointerEnd);
      },
    );
  }

  void onPointerColorChange(Color color) {
    final newColor = color.withOpacity(0.4);
    paintController!.clear();
    paintController!.setPointerColor(newColor);
    addEvent(
      name: Events.pointerColor,
      color: newColor,
    );
  }

  void addEvent({
    required Events name,
    int? index,
    double? x,
    double? y,
    Color? color,
  }) {
    final box = paintKey.currentContext!.findRenderObject() as RenderBox;
    final height = box.size.height;
    final width = box.size.width;
    eventList.add(
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

  void reset() {
    remainingDurationNotifier.value =
        Duration(seconds: LessonConstants.totalSeconds);
    countDownTimer?.cancel();
    countDownTimer = null;
    paintController!.clear();
    initPaintController();
  }

  @override
  void dispose() {
    reset();
    remainingDurationNotifier.dispose();
  }
}
