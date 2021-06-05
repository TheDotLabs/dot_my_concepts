import 'package:flutter/material.dart';

import 'painter_controller.dart';

class PathHistory {
  PathHistory({
    required this.painterController,
    required this.paint,
  });

  Path path = Path();
  final backgroundPaint = Paint()..color = Colors.transparent;
  final Paint paint;
  bool _inDrag = false;
  final PainterController painterController;

  void draw(Canvas canvas, Size size) {
    canvas
      // ..drawRect(
      //   Rect.fromLTWH(0, 0, size.width, size.height),
      //   backgroundPaint,
      // )
      ..drawPath(path, paint);
  }

  void onPointerStart(double x, double y) {
    if (!_inDrag) {
      final startPoint = Offset(x, y);
      _inDrag = true;
      path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
    }
  }

  void onPointerMove(double x, double y) {
    if (_inDrag) {
      final nextPoint = Offset(x, y);
      path.lineTo(nextPoint.dx, nextPoint.dy);
    }
  }

  void onPointerEnd() {
    _inDrag = false;
  }

  // ignore: use_setters_to_change_properties
  void setPointerColor(Color color) {
    paint.color = color;
  }

  void clear() {
    path = Path();
    painterController.notifyListeners();
  }
}
