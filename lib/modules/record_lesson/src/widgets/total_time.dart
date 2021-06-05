import 'package:flutter/material.dart';

class TotalTime extends StatelessWidget {
  const TotalTime({
    required this.duration,
    Key? key,
  }) : super(key: key);
  final int duration;

  @override
  Widget build(BuildContext context) {
    return Text(
      Duration(milliseconds: duration)
          .toString()
          .split('.')[0]
          .padLeft(8, '0')
          .substring(3, 8),
      style: TextStyle(
        fontSize: 12,
        color: Colors.white,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
