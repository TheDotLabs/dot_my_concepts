import 'package:freezed_annotation/freezed_annotation.dart';

part 'my_event.freezed.dart';
part 'my_event.g.dart';

@freezed
class Lesson with _$Lesson {
  factory Lesson({
    required String id,
    required String uid,
    required String name,
    required String description,
    required String course,
    required String category,
    required String subject,
    required String unit,
    required String chapter,
    List<String>? upvotes,
    int? duration,
    List<String>? images,
    String? audioUrl,
    String? eventsUrl,
    // Raw data
    @JsonKey(includeIfNull: false) List<String>? rawImagePaths,
    @JsonKey(includeIfNull: false) String? audioPath,
    @JsonKey(includeIfNull: false) List<MyEvent>? events,
  }) = _Lesson;

  factory Lesson.fromJson(Map<String, dynamic> json) => _$LessonFromJson(json);
}

@freezed
class MyEvent with _$MyEvent {
  factory MyEvent({
    @JsonKey(name: 'e', includeIfNull: false) required Events event,
    @JsonKey(name: 'i', includeIfNull: false) int? index,
    @JsonKey(name: 't', includeIfNull: false) required int time,
    @JsonKey(name: 'c', includeIfNull: false) String? color,
    double? x,
    double? y,
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
    if (this == Events.changeImage) {
      return 'i';
    } else if (this == Events.pointerStart) {
      return 'p_s';
    } else if (this == Events.pointerMove) {
      return 'p_m';
    } else if (this == Events.pointerEnd) {
      return 'p_e';
    } else {
      return 'NA';
    }
  }
}
