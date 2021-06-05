import 'package:flutter/material.dart';

class VideoPlayContainer extends StatelessWidget {
  const VideoPlayContainer({
    required this.isVideoPlaying,
    required this.onTap,
    Key? key,
  }) : super(key: key);
  final bool isVideoPlaying;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: isVideoPlaying,
        child: AnimatedOpacity(
          opacity: isVideoPlaying ? 0.0 : 1.0,
          duration: Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black54,
            ),
            child: Center(
              child: Container(
                child: (!isVideoPlaying)
                    ? FloatingActionButton(
                        onPressed: onTap,
                        child: Icon(
                          Icons.play_arrow,
                          color: Colors.white,
                          size: 32,
                        ),
                      )
                    : Container(),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
