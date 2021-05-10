import 'package:flutter/material.dart';

class FadeScreen extends StatelessWidget {
  const FadeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black.withOpacity(0.78),
    );
  }
}
