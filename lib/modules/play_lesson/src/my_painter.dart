import 'package:flutter/material.dart';

import 'path_history.dart';

class MyPainter extends CustomPainter {
  MyPainter(
    this._path, {
    Listenable? repaint,
  }) : super(repaint: repaint);

  final PathHistory _path;

  @override
  void paint(Canvas canvas, Size size) {
    _path.draw(canvas, size);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return false;
  }
}
