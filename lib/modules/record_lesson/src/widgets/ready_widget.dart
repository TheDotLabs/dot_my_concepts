import 'package:flutter/material.dart';

class ReadyWidget extends StatelessWidget {
  const ReadyWidget({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Tap to start when ready",
          style: TextStyle(color: Colors.white),
        ),
        SizedBox(
          height: 32,
        ),
        RaisedButton.icon(
          color: Colors.redAccent,
          icon: Icon(
            Icons.fiber_manual_record,
            color: Colors.white,
          ),
          onPressed: onTap,
          label: Text("START RECORDING"),
        ),
        SizedBox(
          height: 32,
        ),
        Text(
          "For best audio, ensure you\nare in quiet room",
          style: TextStyle(
            color: Colors.white,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
