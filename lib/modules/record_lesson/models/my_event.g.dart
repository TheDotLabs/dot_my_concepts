// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyEvent _$_$_MyEventFromJson(Map<String, dynamic> json) {
  return _$_MyEvent(
    event: _$enumDecodeNullable(_$EventsEnumMap, json['event']),
    index: json['index'] as int,
    time: json['time'] as int,
    x: (json['x'] as num)?.toDouble(),
    y: (json['y'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_MyEventToJson(_$_MyEvent instance) =>
    <String, dynamic>{
      'event': _$EventsEnumMap[instance.event],
      'index': instance.index,
      'time': instance.time,
      'x': instance.x,
      'y': instance.y,
    };

T _$enumDecode<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    throw ArgumentError('A value must be provided. Supported values: '
        '${enumValues.values.join(', ')}');
  }

  final value = enumValues.entries
      .singleWhere((e) => e.value == source, orElse: () => null)
      ?.key;

  if (value == null && unknownValue == null) {
    throw ArgumentError('`$source` is not one of the supported values: '
        '${enumValues.values.join(', ')}');
  }
  return value ?? unknownValue;
}

T _$enumDecodeNullable<T>(
  Map<T, dynamic> enumValues,
  dynamic source, {
  T unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<T>(enumValues, source, unknownValue: unknownValue);
}

const _$EventsEnumMap = {
  Events.changeImage: 'image',
  Events.pointerStart: 'pointer_start',
  Events.pointerMove: 'pointer_move',
  Events.pointerEnd: 'pointer_end',
};
