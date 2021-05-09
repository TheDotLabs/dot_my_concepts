import 'package:flutter/material.dart';

class EmptyText extends StatelessWidget {
  EmptyText({this.msg});

  final String? msg;

  @override
  Widget build(BuildContext context) {
    return Text(
      msg ?? 'No items found',
      style: TextStyle(
        fontStyle: FontStyle.italic,
        fontSize: 12,
      ),
      textAlign: TextAlign.center,
    );
  }
}
