// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lesson _$_$_LessonFromJson(Map<String, dynamic> json) {
  return _$_Lesson(
    events: (json['events'] as List<dynamic>?)
        ?.map((e) => MyEvent.fromJson(e as Map<String, dynamic>))
        .toList(),
    id: json['id'] as String?,
    duration: json['duration'] as int?,
    name: json['name'] as String?,
    description: json['description'] as String?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    category: json['category'] as String?,
    subject: json['subject'] as String?,
    unit: json['unit'] as String?,
    chapter: json['chapter'] as String?,
  );
}

Map<String, dynamic> _$_$_LessonToJson(_$_Lesson instance) => <String, dynamic>{
      'events': instance.events,
      'id': instance.id,
      'duration': instance.duration,
      'name': instance.name,
      'description': instance.description,
      'images': instance.images,
      'category': instance.category,
      'subject': instance.subject,
      'unit': instance.unit,
      'chapter': instance.chapter,
    };

_$_MyEvent _$_$_MyEventFromJson(Map<String, dynamic> json) {
  return _$_MyEvent(
    event: _$enumDecodeNullable(_$EventsEnumMap, json['e']),
    index: json['i'] as int?,
    time: json['t'] as int?,
    color: json['c'] as String?,
    x: (json['x'] as num?)?.toDouble(),
    y: (json['y'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_MyEventToJson(_$_MyEvent instance) =>
    <String, dynamic>{
      'e': _$EventsEnumMap[instance.event],
      'i': instance.index,
      't': instance.time,
      'c': instance.color,
      'x': instance.x,
      'y': instance.y,
    };

K _$enumDecode<K, V>(
  Map<K, V> enumValues,
  Object? source, {
  K? unknownValue,
}) {
  if (source == null) {
    throw ArgumentError(
      'A value must be provided. Supported values: '
      '${enumValues.values.join(', ')}',
    );
  }

  return enumValues.entries.singleWhere(
    (e) => e.value == source,
    orElse: () {
      if (unknownValue == null) {
        throw ArgumentError(
          '`$source` is not one of the supported values: '
          '${enumValues.values.join(', ')}',
        );
      }
      return MapEntry(unknownValue, enumValues.values.first);
    },
  ).key;
}

K? _$enumDecodeNullable<K, V>(
  Map<K, V> enumValues,
  dynamic source, {
  K? unknownValue,
}) {
  if (source == null) {
    return null;
  }
  return _$enumDecode<K, V>(enumValues, source, unknownValue: unknownValue);
}

const _$EventsEnumMap = {
  Events.changeImage: 'i',
  Events.pointerStart: 'p_s',
  Events.pointerMove: 'p_m',
  Events.pointerEnd: 'p_e',
  Events.pointerColor: 'p_c',
};
