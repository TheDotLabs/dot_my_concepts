// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lesson _$_$_LessonFromJson(Map<String, dynamic> json) {
  return _$_Lesson(
    events: (json['events'] as List)
        ?.map((e) =>
            e == null ? null : MyEvent.fromJson(e as Map<String, dynamic>))
        ?.toList(),
    id: json['id'] as String,
    duration: json['duration'] as int,
    name: json['name'] as String,
    description: json['description'] as String,
    images: (json['images'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$_$_LessonToJson(_$_Lesson instance) => <String, dynamic>{
      'events': instance.events,
      'id': instance.id,
      'duration': instance.duration,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
    };

_$_MyEvent _$_$_MyEventFromJson(Map<String, dynamic> json) {
  return _$_MyEvent(
    event: _$enumDecodeNullable(_$EventsEnumMap, json['e']),
    index: json['i'] as int,
    time: json['t'] as int,
    x: (json['x'] as num)?.toDouble(),
    y: (json['y'] as num)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_MyEventToJson(_$_MyEvent instance) =>
    <String, dynamic>{
      'e': _$EventsEnumMap[instance.event],
      'i': instance.index,
      't': instance.time,
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
  Events.changeImage: 'i',
  Events.pointerStart: 'p_s',
  Events.pointerMove: 'p_m',
  Events.pointerEnd: 'p_e',
};
