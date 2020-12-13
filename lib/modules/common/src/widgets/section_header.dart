import 'package:flutter/material.dart';

class SectionHeader extends StatelessWidget {
  SectionHeader(this.msg);

  final String msg;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Text(
        msg.toUpperCase(),
        textAlign: TextAlign.center,
        style: Theme.of(context).textTheme.overline,
      ),
    );
  }
}
