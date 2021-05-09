import 'package:flutter/material.dart';

class NoItemFound extends StatelessWidget {
  final String? msg;

  NoItemFound({this.msg});

  @override
  Widget build(BuildContext context) {
    return Text(msg ?? 'No items found');
  }
}
