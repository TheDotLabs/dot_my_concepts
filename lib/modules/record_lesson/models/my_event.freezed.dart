// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies

part of 'my_event.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;
MyEvent _$MyEventFromJson(Map<String, dynamic> json) {
  return _MyEvent.fromJson(json);
}

class _$MyEventTearOff {
  const _$MyEventTearOff();

// ignore: unused_element
  _MyEvent call({Events event, int index, int time, double x, double y}) {
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
  Events get event;
  int get index;
  int get time;
  double get x;
  double get y;

  Map<String, dynamic> toJson();
  $MyEventCopyWith<MyEvent> get copyWith;
}

abstract class $MyEventCopyWith<$Res> {
  factory $MyEventCopyWith(MyEvent value, $Res Function(MyEvent) then) =
      _$MyEventCopyWithImpl<$Res>;
  $Res call({Events event, int index, int time, double x, double y});
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
  $Res call({Events event, int index, int time, double x, double y});
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
  _$_MyEvent({this.event, this.index, this.time, this.x, this.y});

  factory _$_MyEvent.fromJson(Map<String, dynamic> json) =>
      _$_$_MyEventFromJson(json);

  @override
  final Events event;
  @override
  final int index;
  @override
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
  factory _MyEvent({Events event, int index, int time, double x, double y}) =
      _$_MyEvent;

  factory _MyEvent.fromJson(Map<String, dynamic> json) = _$_MyEvent.fromJson;

  @override
  Events get event;
  @override
  int get index;
  @override
  int get time;
  @override
  double get x;
  @override
  double get y;
  @override
  _$MyEventCopyWith<_MyEvent> get copyWith;
}
