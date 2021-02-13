import 'package:flutter/material.dart';

class BoxHeader extends StatelessWidget {
  BoxHeader(
    this.title, {
    this.margin = const EdgeInsets.all(8.0),
    this.padding = const EdgeInsets.all(8.0),
    this.fontSize = 12,
  });

  final String title;
  final EdgeInsets margin;
  final EdgeInsets padding;
  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      decoration: BoxDecoration(
        color: Colors.blueGrey[50],
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        (title ?? "--").toUpperCase(),
        style: Theme.of(context).textTheme.overline.copyWith(
              fontSize: fontSize,
            ),
      ),
    );
  }
}
