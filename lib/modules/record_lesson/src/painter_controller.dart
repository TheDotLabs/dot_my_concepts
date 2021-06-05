import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart' hide Image;

class PainterWidget extends StatefulWidget {
  final PainterController? painterController;

  final VoidCallback onTouch;
  final bool disableTouch;

  PainterWidget(
    this.painterController,
    this.onTouch, {
    this.disableTouch = false,
  }) : super(
          key: ValueKey<PainterController?>(painterController),
        );

  @override
  _PainterWidgetState createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {
  final _finished = false;

  @override
  Widget build(BuildContext context) {
    Widget child = ClipRect(
      child: CustomPaint(
        isComplex: true,
        willChange: true,
        painter: MyPainter(
          widget.painterController!._pathHistory,
          repaint: widget.painterController,
        ),
        child: Container(
          height: 500,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
    if (!_finished && !widget.disableTouch) {
      child = GestureDetector(
        onPanStart: _onPanStart,
        onPanUpdate: _onPanUpdate,
        onPanEnd: _onPanEnd,
        child: child,
      );
    }
    return child;
  }

  void _onPanStart(DragStartDetails start) {
    final pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(start.globalPosition);
    widget.painterController!._pathHistory!.add(pos);
    widget.painterController!.notifyListeners();
  }

  void _onPanUpdate(DragUpdateDetails update) {
    final pos = (context.findRenderObject() as RenderBox)
        .globalToLocal(update.globalPosition);
    widget.painterController!._pathHistory!.updateCurrent(pos);
    widget.painterController!.notifyListeners();
  }

  void _onPanEnd(DragEndDetails end) {
    widget.painterController!._pathHistory!.endCurrent();
    widget.painterController!.notifyListeners();
  }
}

class MyPainter extends CustomPainter {
  MyPainter(
    this._path, {
    Listenable? repaint,
  }) : super(repaint: repaint);

  final PathHistory? _path;

  @override
  void paint(Canvas canvas, Size size) {
    _path!.draw(canvas, size);
  }

  @override
  bool shouldRepaint(MyPainter oldDelegate) {
    return false;
  }
}

class PathHistory {
  Path path = Path();
  late Paint backgroundPaint;
  Paint? paint;
  late bool _inDrag;

  PainterController? painterController;

  PathHistory({
    required Color backgroundColor,
    this.paint,
    this.painterController,
  }) {
    _inDrag = false;
    backgroundPaint = Paint()..color = backgroundColor;
  }

  void add(Offset startPoint) {
    if (!_inDrag) {
      _inDrag = true;
      path = Path();
      path.moveTo(startPoint.dx, startPoint.dy);
      if (painterController!.startMotion != null) {
        painterController!.startMotion!(startPoint.dx, startPoint.dy);
      }
    }
  }

  void updateCurrent(Offset nextPoint) {
    if (_inDrag) {
      path.lineTo(nextPoint.dx, nextPoint.dy);
      if (painterController!.moveMotion != null) {
        painterController!.moveMotion!(nextPoint.dx, nextPoint.dy);
      }
    }
  }

  void endCurrent() {
    _inDrag = false;
    if (painterController!.endMotion != null) {
      painterController!.endMotion!();
    }
  }

  void draw(Canvas canvas, Size size) {
    canvas.drawRect(
      Rect.fromLTWH(0, 0, size.width, size.height),
      backgroundPaint,
    );
    canvas.drawPath(path, paint!);
  }

  void clear() {
    path = Path();
    painterController!.notifyListeners();
  }

  void onPointerStart(double x, double y) {
    add(Offset(x, y));
  }

  void onPointerMove(double x, double y) {
    updateCurrent(Offset(x, y));
  }

  void onPointerEnd() {
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

  @override
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
