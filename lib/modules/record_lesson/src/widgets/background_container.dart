import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/constants/lesson_constants.dart';

class BackgroundContainer extends StatelessWidget {
  const BackgroundContainer({required this.child, Key? key}) : super(key: key);
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      color: Colors.black87,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight:
              (MediaQuery.of(context).orientation == Orientation.landscape)
                  ? MediaQuery.of(context).size.height
                  : 500,
        ),
        child: ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight:
                (MediaQuery.of(context).orientation == Orientation.landscape)
                    ? MediaQuery.of(context).size.height
                    : 500,
          ),
          child: AspectRatio(
            aspectRatio: LessonConstants.aspectRatio,
            child: IntrinsicWidth(
              child: IntrinsicHeight(
                child: child,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
