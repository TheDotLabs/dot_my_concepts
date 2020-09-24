import 'package:flutter/material.dart';

class BorderContainer extends StatelessWidget {
  BorderContainer({this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(2),
      decoration: new BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        boxShadow: [
          BoxShadow(
            color: Colors.blueGrey.withOpacity(0.4),
            blurRadius: 1.6, // soften the shadow
            spreadRadius: 0.0, //extend the shadow
          )
        ],
        color: Theme.of(context).cardColor,
      ),
      clipBehavior: Clip.antiAlias,
      child: child,
    );
  }
}
