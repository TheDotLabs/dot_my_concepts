import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_event.freezed.dart';
part 'my_event.g.dart';

@freezed
abstract class Lesson with _$Lesson {
  factory Lesson({
    List<MyEvent> events,
    String id,
    int duration,
    String name,
    String description,
    List<String> images,
    String category,
    String subject,
    String unit,
    String chapter,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@freezed
abstract class MyEvent with _$MyEvent {
  factory MyEvent({
    @JsonKey(name: 'e') Events event,
    @JsonKey(name: 'i') int index,
    @JsonKey(name: 't') int time,
    @JsonKey(name: 'c') String color,
    double x,
    double y,
  }) = _MyEvent;

  factory MyEvent.fromJson(Map<String, dynamic> json) =>
      _$MyEventFromJson(json);
}

enum Events {
  @JsonValue('i')
  changeImage,
  @JsonValue('p_s')
  pointerStart,
  @JsonValue('p_m')
  pointerMove,
  @JsonValue('p_e')
  pointerEnd,
  @JsonValue('p_c')
  pointerColor,
}

extension EventsX on Events {
  String getName() {
    if (this == Events.changeImage) return 'i';
    if (this == Events.pointerStart) return 'p_s';
    if (this == Events.pointerMove) return 'p_m';
    if (this == Events.pointerEnd)
      return 'p_e';
    else
      return 'NA';
  }
}
