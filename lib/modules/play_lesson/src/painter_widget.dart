import 'package:flutter/material.dart';

import 'my_painter.dart';
import 'painter_controller.dart';

class PainterWidget extends StatefulWidget {
  PainterWidget(
    this.painterController,
  ) : super(key: ValueKey<PainterController?>(painterController));

  final PainterController painterController;

  @override
  _PainterWidgetState createState() => _PainterWidgetState();
}

class _PainterWidgetState extends State<PainterWidget> {
  @override
  Widget build(BuildContext context) {
    final child = ClipRect(
      child: CustomPaint(
        isComplex: true,
        willChange: true,
        painter: MyPainter(
          widget.painterController.pathHistory,
          repaint: widget.painterController,
        ),
        child: Container(
          height: (MediaQuery.of(context).orientation == Orientation.landscape)
              ? MediaQuery.of(context).size.height
              : 500,
          width: MediaQuery.of(context).size.width,
        ),
      ),
    );
    return child;
  }
}
