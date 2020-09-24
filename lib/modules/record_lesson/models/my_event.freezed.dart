// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'my_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
Lesson _$LessonFromJson(Map<String, dynamic> json) {
  return _Lesson.fromJson(json);
}

class _$LessonTearOff {
  const _$LessonTearOff();

// ignore: unused_element
  _Lesson call(
      {List<MyEvent> events,
      String id,
      int duration,
      String name,
      String description,
      List<String> images,
      String category,
      String subject,
      String unit,
      String chapter}) {
    return _Lesson(
      events: events,
      id: id,
      duration: duration,
      name: name,
      description: description,
      images: images,
      category: category,
      subject: subject,
      unit: unit,
      chapter: chapter,
    );
  }
}

// ignore: unused_element
const $Lesson = _$LessonTearOff();

mixin _$Lesson {
  List<MyEvent> get events;
  String get id;
  int get duration;
  String get name;
  String get description;
  List<String> get images;
  String get category;
  String get subject;
  String get unit;
  String get chapter;

  Map<String, dynamic> toJson();
  $LessonCopyWith<Lesson> get copyWith;
}

abstract class $LessonCopyWith<$Res> {
  factory $LessonCopyWith(Lesson value, $Res Function(Lesson) then) =
      _$LessonCopyWithImpl<$Res>;
  $Res call(
      {List<MyEvent> events,
      String id,
      int duration,
      String name,
      String description,
      List<String> images,
      String category,
      String subject,
      String unit,
      String chapter});
}

class _$LessonCopyWithImpl<$Res> implements $LessonCopyWith<$Res> {
  _$LessonCopyWithImpl(this._value, this._then);

  final Lesson _value;
  // ignore: unused_field
  final $Res Function(Lesson) _then;

  @override
  $Res call({
    Object events = freezed,
    Object id = freezed,
    Object duration = freezed,
    Object name = freezed,
    Object description = freezed,
    Object images = freezed,
    Object category = freezed,
    Object subject = freezed,
    Object unit = freezed,
    Object chapter = freezed,
  }) {
    return _then(_value.copyWith(
      events: events == freezed ? _value.events : events as List<MyEvent>,
      id: id == freezed ? _value.id : id as String,
      duration: duration == freezed ? _value.duration : duration as int,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      images: images == freezed ? _value.images : images as List<String>,
      category: category == freezed ? _value.category : category as String,
      subject: subject == freezed ? _value.subject : subject as String,
      unit: unit == freezed ? _value.unit : unit as String,
      chapter: chapter == freezed ? _value.chapter : chapter as String,
    ));
  }
}

abstract class _$LessonCopyWith<$Res> implements $LessonCopyWith<$Res> {
  factory _$LessonCopyWith(_Lesson value, $Res Function(_Lesson) then) =
      __$LessonCopyWithImpl<$Res>;
  @override
  $Res call(
      {List<MyEvent> events,
      String id,
      int duration,
      String name,
      String description,
      List<String> images,
      String category,
      String subject,
      String unit,
      String chapter});
}

class __$LessonCopyWithImpl<$Res> extends _$LessonCopyWithImpl<$Res>
    implements _$LessonCopyWith<$Res> {
  __$LessonCopyWithImpl(_Lesson _value, $Res Function(_Lesson) _then)
      : super(_value, (v) => _then(v as _Lesson));

  @override
  _Lesson get _value => super._value as _Lesson;

  @override
  $Res call({
    Object events = freezed,
    Object id = freezed,
    Object duration = freezed,
    Object name = freezed,
    Object description = freezed,
    Object images = freezed,
    Object category = freezed,
    Object subject = freezed,
    Object unit = freezed,
    Object chapter = freezed,
  }) {
    return _then(_Lesson(
      events: events == freezed ? _value.events : events as List<MyEvent>,
      id: id == freezed ? _value.id : id as String,
      duration: duration == freezed ? _value.duration : duration as int,
      name: name == freezed ? _value.name : name as String,
      description:
          description == freezed ? _value.description : description as String,
      images: images == freezed ? _value.images : images as List<String>,
      category: category == freezed ? _value.category : category as String,
      subject: subject == freezed ? _value.subject : subject as String,
      unit: unit == freezed ? _value.unit : unit as String,
      chapter: chapter == freezed ? _value.chapter : chapter as String,
    ));
  }
}

@JsonSerializable()
class _$_Lesson implements _Lesson {
  _$_Lesson(
      {this.events,
      this.id,
      this.duration,
      this.name,
      this.description,
      this.images,
      this.category,
      this.subject,
      this.unit,
      this.chapter});

  factory _$_Lesson.fromJson(Map<String, dynamic> json) =>
      _$_$_LessonFromJson(json);

  @override
  final List<MyEvent> events;
  @override
  final String id;
  @override
  final int duration;
  @override
  final String name;
  @override
  final String description;
  @override
  final List<String> images;
  @override
  final String category;
  @override
  final String subject;
  @override
  final String unit;
  @override
  final String chapter;

  @override
  String toString() {
    return 'Lesson(events: $events, id: $id, duration: $duration, name: $name, description: $description, images: $images, category: $category, subject: $subject, unit: $unit, chapter: $chapter)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Lesson &&
            (identical(other.events, events) ||
                const DeepCollectionEquality().equals(other.events, events)) &&
            (identical(other.id, id) ||
                const DeepCollectionEquality().equals(other.id, id)) &&
            (identical(other.duration, duration) ||
                const DeepCollectionEquality()
                    .equals(other.duration, duration)) &&
            (identical(other.name, name) ||
                const DeepCollectionEquality().equals(other.name, name)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.images, images) ||
                const DeepCollectionEquality().equals(other.images, images)) &&
            (identical(other.category, category) ||
                const DeepCollectionEquality()
                    .equals(other.category, category)) &&
            (identical(other.subject, subject) ||
                const DeepCollectionEquality()
                    .equals(other.subject, subject)) &&
            (identical(other.unit, unit) ||
                const DeepCollectionEquality().equals(other.unit, unit)) &&
            (identical(other.chapter, chapter) ||
                const DeepCollectionEquality().equals(other.chapter, chapter)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(events) ^
      const DeepCollectionEquality().hash(id) ^
      const DeepCollectionEquality().hash(duration) ^
      const DeepCollectionEquality().hash(name) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(images) ^
      const DeepCollectionEquality().hash(category) ^
      const DeepCollectionEquality().hash(subject) ^
      const DeepCollectionEquality().hash(unit) ^
      const DeepCollectionEquality().hash(chapter);

  @override
  _$LessonCopyWith<_Lesson> get copyWith =>
      __$LessonCopyWithImpl<_Lesson>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_LessonToJson(this);
  }
}

abstract class _Lesson implements Lesson {
  factory _Lesson(
      {List<MyEvent> events,
      String id,
      int duration,
      String name,
      String description,
      List<String> images,
      String category,
      String subject,
      String unit,
      String chapter}) = _$_Lesson;

  factory _Lesson.fromJson(Map<String, dynamic> json) = _$_Lesson.fromJson;

  @override
  List<MyEvent> get events;
  @override
  String get id;
  @override
  int get duration;
  @override
  String get name;
  @override
  String get description;
  @override
  List<String> get images;
  @override
  String get category;
  @override
  String get subject;
  @override
  String get unit;
  @override
  String get chapter;
  @override
  _$LessonCopyWith<_Lesson> get copyWith;
}

MyEvent _$MyEventFromJson(Map<String, dynamic> json) {
  return _MyEvent.fromJson(json);
}

class _$MyEventTearOff {
  const _$MyEventTearOff();

// ignore: unused_element
  _MyEvent call(
      {@JsonKey(name: 'e') Events event,
      @JsonKey(name: 'i') int index,
      @JsonKey(name: 't') int time,
      double x,
      double y}) {
    return _MyEvent(
      event: event,
      index: index,
      time: time,
      x: x,
      y: y,
    );
  }
}

// ignore: unused_element
const $MyEvent = _$MyEventTearOff();

mixin _$MyEvent {
  @JsonKey(name: 'e')
  Events get event;
  @JsonKey(name: 'i')
  int get index;
  @JsonKey(name: 't')
  int get time;
  double get x;
  double get y;

  Map<String, dynamic> toJson();
  $MyEventCopyWith<MyEvent> get copyWith;
}

abstract class $MyEventCopyWith<$Res> {
  factory $MyEventCopyWith(MyEvent value, $Res Function(MyEvent) then) =
      _$MyEventCopyWithImpl<$Res>;
  $Res call(
      {@JsonKey(name: 'e') Events event,
      @JsonKey(name: 'i') int index,
      @JsonKey(name: 't') int time,
      double x,
      double y});
}

class _$MyEventCopyWithImpl<$Res> implements $MyEventCopyWith<$Res> {
  _$MyEventCopyWithImpl(this._value, this._then);

  final MyEvent _value;
  // ignore: unused_field
  final $Res Function(MyEvent) _then;

  @override
  $Res call({
    Object event = freezed,
    Object index = freezed,
    Object time = freezed,
    Object x = freezed,
    Object y = freezed,
  }) {
    return _then(_value.copyWith(
      event: event == freezed ? _value.event : event as Events,
      index: index == freezed ? _value.index : index as int,
      time: time == freezed ? _value.time : time as int,
      x: x == freezed ? _value.x : x as double,
      y: y == freezed ? _value.y : y as double,
    ));
  }
}

abstract class _$MyEventCopyWith<$Res> implements $MyEventCopyWith<$Res> {
  factory _$MyEventCopyWith(_MyEvent value, $Res Function(_MyEvent) then) =
      __$MyEventCopyWithImpl<$Res>;
  @override
  $Res call(
      {@JsonKey(name: 'e') Events event,
      @JsonKey(name: 'i') int index,
      @JsonKey(name: 't') int time,
      double x,
      double y});
}

class __$MyEventCopyWithImpl<$Res> extends _$MyEventCopyWithImpl<$Res>
    implements _$MyEventCopyWith<$Res> {
  __$MyEventCopyWithImpl(_MyEvent _value, $Res Function(_MyEvent) _then)
      : super(_value, (v) => _then(v as _MyEvent));

  @override
  _MyEvent get _value => super._value as _MyEvent;

  @override
  $Res call({
    Object event = freezed,
    Object index = freezed,
    Object time = freezed,
    Object x = freezed,
    Object y = freezed,
  }) {
    return _then(_MyEvent(
      event: event == freezed ? _value.event : event as Events,
      index: index == freezed ? _value.index : index as int,
      time: time == freezed ? _value.time : time as int,
      x: x == freezed ? _value.x : x as double,
      y: y == freezed ? _value.y : y as double,
    ));
  }
}

@JsonSerializable()
class _$_MyEvent implements _MyEvent {
  _$_MyEvent(
      {@JsonKey(name: 'e') this.event,
      @JsonKey(name: 'i') this.index,
      @JsonKey(name: 't') this.time,
      this.x,
      this.y});

  factory _$_MyEvent.fromJson(Map<String, dynamic> json) =>
      _$_$_MyEventFromJson(json);

  @override
  @JsonKey(name: 'e')
  final Events event;
  @override
  @JsonKey(name: 'i')
  final int index;
  @override
  @JsonKey(name: 't')
  final int time;
  @override
  final double x;
  @override
  final double y;

  @override
  String toString() {
    return 'MyEvent(event: $event, index: $index, time: $time, x: $x, y: $y)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _MyEvent &&
            (identical(other.event, event) ||
                const DeepCollectionEquality().equals(other.event, event)) &&
            (identical(other.index, index) ||
                const DeepCollectionEquality().equals(other.index, index)) &&
            (identical(other.time, time) ||
                const DeepCollectionEquality().equals(other.time, time)) &&
            (identical(other.x, x) ||
                const DeepCollectionEquality().equals(other.x, x)) &&
            (identical(other.y, y) ||
                const DeepCollectionEquality().equals(other.y, y)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(event) ^
      const DeepCollectionEquality().hash(index) ^
      const DeepCollectionEquality().hash(time) ^
      const DeepCollectionEquality().hash(x) ^
      const DeepCollectionEquality().hash(y);

  @override
  _$MyEventCopyWith<_MyEvent> get copyWith =>
      __$MyEventCopyWithImpl<_MyEvent>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$_$_MyEventToJson(this);
  }
}

abstract class _MyEvent implements MyEvent {
  factory _MyEvent(
      {@JsonKey(name: 'e') Events event,
      @JsonKey(name: 'i') int index,
      @JsonKey(name: 't') int time,
      double x,
      double y}) = _$_MyEvent;

  factory _MyEvent.fromJson(Map<String, dynamic> json) = _$_MyEvent.fromJson;

  @override
  @JsonKey(name: 'e')
  Events get event;
  @override
  @JsonKey(name: 'i')
  int get index;
  @override
  @JsonKey(name: 't')
  int get time;
  @override
  double get x;
  @override
  double get y;
  @override
  _$MyEventCopyWith<_MyEvent> get copyWith;
}
