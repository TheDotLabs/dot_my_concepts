import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/elapsed_time.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/total_time.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/widgets/video_pause_container.dart';
import 'package:provider/provider.dart';

import '../bloc.dart';

typedef ResumeTap = void Function(double?);

class VideoControlsContainer extends StatelessWidget {
  const VideoControlsContainer({
    required this.onPauseTap,
    required this.fullScreenTap,
    required this.onResumeTap,
    required this.showVideoControls,
    required this.elapsedTimeNotifier,
    Key? key,
  }) : super(key: key);

  final VoidCallback onPauseTap;
  final VoidCallback fullScreenTap;
  final ResumeTap onResumeTap;
  final bool showVideoControls;
  final ValueNotifier<int> elapsedTimeNotifier;

  @override
  Widget build(BuildContext context) {
    final bloc = context.read<Bloc>();
    return Positioned.fill(
      child: IgnorePointer(
        ignoring: !showVideoControls,
        child: AnimatedOpacity(
          opacity: showVideoControls ? 1.0 : 0.0,
          duration: Duration(milliseconds: 200),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black.withOpacity(0.78),
            ),
            child: Column(
              children: [
                VideoPauseContainer(
                  onTap: onPauseTap,
                ),
                ValueListenableBuilder<int>(
                  valueListenable: elapsedTimeNotifier,
                  builder: (_, oldValue, __) {
                    final value = oldValue > bloc.lesson!.duration!.toInt()
                        ? bloc.lesson!.duration!.toInt()
                        : oldValue;
                    return Row(
                      children: [
                        SizedBox(
                          width: 16,
                        ),
                        ElapsedTime(
                          elapsedTime: value,
                        ),
                        if (bloc.lesson != null)
                          Expanded(
                            child: SliderTheme(
                              data: SliderTheme.of(context).copyWith(
                                thumbShape: RoundSliderThumbShape(
                                  enabledThumbRadius: 8,
                                ),
                              ),
                              child: Slider(
                                value: value.toDouble(),
                                min: 0,
                                max: bloc.lesson!.duration!.toDouble(),
                                onChanged: onResumeTap,
                              ),
                            ),
                          ),
                        TotalTime(
                          duration: bloc.lesson!.duration!,
                        ),
                        GestureDetector(
                          onTap: fullScreenTap,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Icon(
                              Icons.fullscreen,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                      ],
                    );
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
