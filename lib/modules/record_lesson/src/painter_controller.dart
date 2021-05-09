import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Image;

class Painter extends StatefulWidget {
  final PainterController? painterController;

  final VoidCallback onTouch;
  final bool disableTouch;

  Painter(
    this.painterController,
    this.onTouch, {
    this.disableTouch = false,
  }) : super(
          key: ValueKey<PainterController?>(painterController),
        );

  @override
  _PainterState createState() => _PainterState();
}

class _PainterState extends State<Painter> {
  bool _finished = false;

  @override
  Widget build(BuildContext context) {
    Widget child = CustomPaint(
      isComplex: true,
      willChange: true,
      painter: PainterPainter(
        widget.painterController!._pathHistory,
        repaint: widget.painterController,
      ),
    );
    child = ClipRect(child: child);
    if (!_finished && !widget.disableTouch) {
      child = GestureDetector(
        child: child,
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
      );
    }
    return Container(
      child: child,
      width: double.infinity,
      height: double.infinity,
    );
  }

  void _onPanStart(DragStartDetails start) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController!._pathHistory!.add(pos);
    widget.painterController!.notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    Offset pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController!._pathHistory!.updateCurrent(pos);
    widget.painterController!.notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController!._pathHistory!.endCurrent();
    widget.painterController!.notifyListeners();
  }
}

class PainterPainter extends CustomPainter {
  final PathHistory? _path;

  PainterPainter(this._path, {Listenable? repaint}) : super(repaint: repaint);

  @override
  void paint(Canvas canvas, Size size) {
    _path!.draw(canvas, size);
  }

  @override
  bool shouldRepaint(PainterPainter oldDelegate) {
    return false;
  }
}

class PathHistory {
  var path = new Path();
  late Paint backgroundPaint;
  Paint? paint;
  late bool _inDrag;

  PainterController? painterController;

  PathHistory({required Color backgroundColor, this.paint, this.painterController}) {
    _inDrag = false;
    backgroundPaint = Paint()..color = backgroundColor;
  }

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      path = new Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      if (painterController!.startMotion != null)
        painterController!.startMotion!(startPoint.dx, startPoint.dy);
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      path.lineTo(nextPoint.dx, nextPoint.dy);
      if (painterController!.moveMotion != null)
        painterController!.moveMotion!(nextPoint.dx, nextPoint.dy);
    }
  }

  void endCurrent() {
    _inDrag = false;
    if (painterController!.endMotion != null) painterController!.endMotion!();
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );
    canvas.drawPath(path, paint!);
  }

  void clear() {
    path = new Path();
    painterController!.notifyListeners();
  }

  void onPointerStart(double x, double y) {
    print('on p start');
    add(Offset(x, y));
  }

  void onPointerMove(double x, double y) {
    print('on p move');

    updateCurrent(Offset(x, y));
  }

  void onPointerEnd() {
    print('on p end');

    endCurrent();
  }

  void setPointerColor(Color color) {
    paint!.color = color;
  }
}

typedef PathMotion = void Function(double x, double y);

class PainterController extends ChangeNotifier {
  Color? drawColor;
  Color? backgroundColor;
  double thickness;
  PathHistory? _pathHistory;
  PathMotion? startMotion;
  PathMotion? moveMotion;
  VoidCallback? endMotion;

  PainterController({
    this.backgroundColor,
    this.drawColor,
    this.thickness = 28,
    this.startMotion,
    this.moveMotion,
    this.endMotion,
  }) {
    final paint = Paint()
      ..color = drawColor!
      ..style = PaintingStyle.stroke
      ..strokeWidth = thickness
      ..strokeCap = StrokeCap.round
      ..strokeJoin = StrokeJoin.round;

    _pathHistory = PathHistory(
      backgroundColor: backgroundColor!,
      paint: paint,
      painterController: this,
    );
  }

  void notifyListeners() {
    super.notifyListeners();
  }

  void clear() {
    _pathHistory!.clear();
    notifyListeners();
  }

  void onPointerStart(double x, double y) {
    _pathHistory!.onPointerStart(x, y);
    notifyListeners();
  }

  void onPointerMove(double x, double y) {
    _pathHistory!.onPointerMove(x, y);
    notifyListeners();
  }

  void onPointerEnd() {
    _pathHistory!.onPointerEnd();
    notifyListeners();
  }

  void setPointerColor(Color color) {
    _pathHistory!.setPointerColor(color);
  }
}
