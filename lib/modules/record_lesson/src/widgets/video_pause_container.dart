import 'package:flutter/material.dart';

class VideoPauseContainer extends StatelessWidget {
  const VideoPauseContainer({
    Key? key,
    required this.onTap,
  }) : super(key: key);

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Container(
          margin: EdgeInsets.only(
            top: 44,
          ),
          child: IconButton(
            icon: Icon(
              Icons.pause,
              size: 36,
            ),
            color: Colors.white,
            onPressed: onTap,
          ),
        ),
      ),
    );
  }
}
