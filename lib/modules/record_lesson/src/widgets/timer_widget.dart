import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class TimerWidget extends StatelessWidget {
  const TimerWidget({
    Key? key,
    required this.notifier,
  }) : super(key: key);
  final ValueNotifier<Duration> notifier;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<Duration>(
      valueListenable: notifier,
      builder: (context, value, child) {
        return Container(
          color: Colors.black26,
          padding: EdgeInsets.only(
            top: 4,
            bottom: 4,
            right: 12,
            left: 4,
          ),
          child: Row(
            children: [
              Lottie.asset(
                'assets/lottie/57122-live-pulse-animation.json',
                height: 32,
              ),
              SizedBox(
                width: 8,
              ),
              Text(
                value.toString().split('.')[0].padLeft(8, '0'),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
