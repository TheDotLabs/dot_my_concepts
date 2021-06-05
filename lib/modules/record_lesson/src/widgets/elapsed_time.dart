import 'package:flutter/material.dart';

class ElapsedTime extends StatelessWidget {
  const ElapsedTime({
    required this.elapsedTime,
    Key? key,
  }) : super(key: key);
  final int elapsedTime;

  @override
  Widget build(BuildContext context) {
    return Text(
      Duration(milliseconds: elapsedTime)
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
