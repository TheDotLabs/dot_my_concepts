import 'package:flutter/material.dart';

class StopButton extends StatelessWidget {
  const StopButton({
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
        'STOP',
        style: TextStyle(color: Colors.white),
      ),
      onPressed: onTap,
    );
  }
}
