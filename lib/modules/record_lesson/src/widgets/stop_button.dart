import 'package:flutter/material.dart';

class PauseButton extends StatelessWidget {
  const PauseButton({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return FlatButton.icon(
      height: 36,
      color: Colors.black26,
      icon: Icon(Icons.stop, color: Colors.redAccent),
      label: Text(
        'PAUSE',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onTap,
    );
  }
}
