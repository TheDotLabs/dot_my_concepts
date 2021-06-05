import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Image;

import 'path_history.dart';

class PainterController extends ChangeNotifier {
  PainterController({
    required Color drawColor,
  }) {
    final paint = Paint()
      ..color = drawColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    pathHistory = PathHistory(
      paint: paint,
      painterController: this,
    );
  }

  final double thickness = 28;
  late PathHistory pathHistory;

  @override
  void notifyListeners() {
    super.notifyListeners();
  }

  void onPointerStart(double x, double y) {
    pathHistory.onPointerStart(x, y);
    notifyListeners();
  }

  void onPointerMove(double x, double y) {
    pathHistory.onPointerMove(x, y);
    notifyListeners();
  }

  void onPointerEnd() {
    pathHistory.onPointerEnd();
    notifyListeners();
  }

  void setPointerColor(Color color) {
    pathHistory.setPointerColor(color);
  }

  void clear() {
    pathHistory.clear();
    notifyListeners();
  }
}
