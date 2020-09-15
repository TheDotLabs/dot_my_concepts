import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_event.freezed.dart';
part 'my_event.g.dart';

@freezed
abstract class MyEvent with _$MyEvent {
  factory MyEvent({
    Events event,
    int index,
    int time,
    double x,
    double y,
  }) = _MyEvent;

  factory MyEvent.fromJson(Map<String, dynamic> json) =>
      _$MyEventFromJson(json);
}

enum Events {
  @JsonValue('image')
  changeImage,
  @JsonValue('pointer_start')
  pointerStart,
  @JsonValue('pointer_move')
  pointerMove,
  @JsonValue('pointer_end')
  pointerEnd,
}

extension EventsX on Events {
  String getName() {
    if (this == Events.changeImage) return 'image';
    if (this == Events.pointerStart) return 'pointer_start';
    if (this == Events.pointerMove) return 'pointer_move';
    if (this == Events.pointerEnd)
      return 'pointer_end';
    else
      return 'NA';
  }
}
