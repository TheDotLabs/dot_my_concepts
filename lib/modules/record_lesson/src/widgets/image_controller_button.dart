import 'package:flutter/material.dart';

class ImageControllerButton extends StatelessWidget {
  const ImageControllerButton({
    Key? key,
    required this.opacity,
    required this.onTap,
    required this.icon,
  }) : super(key: key);
  static const _kOpacityDuration = Duration(milliseconds: 100);
  final double opacity;
  final VoidCallback onTap;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: opacity,
      duration: _kOpacityDuration,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black26,
          shape: BoxShape.circle,
        ),
        child: IconButton(
          disabledColor: Colors.white54,
          color: Colors.white,
          icon: icon,
          onPressed: onTap,
        ),
      ),
    );
  }
}
