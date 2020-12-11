import 'package:flutter/material.dart';

class SectionDivider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 8,
      width: MediaQuery.of(context).size.width,
      color: Colors.blueGrey[50],
    );
  }
}
