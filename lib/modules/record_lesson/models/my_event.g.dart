// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Lesson _$_$_LessonFromJson(Map<String, dynamic> json) {
  return _$_Lesson(
    id: json['id'] as String,
    uid: json['uid'] as String,
    name: json['name'] as String,
    description: json['description'] as String,
    course: json['course'] as String,
    category: json['category'] as String,
    subject: json['subject'] as String,
    unit: json['unit'] as String,
    chapter: json['chapter'] as String,
    upvotes:
        (json['upvotes'] as List<dynamic>?)?.map((e) => e as String).toList(),
    duration: json['duration'] as int?,
    images:
        (json['images'] as List<dynamic>?)?.map((e) => e as String).toList(),
    audioUrl: json['audioUrl'] as String?,
    eventsUrl: json['eventsUrl'] as String?,
    rawImagePaths: (json['rawImagePaths'] as List<dynamic>?)
        ?.map((e) => e as String)
        .toList(),
    audioPath: json['audioPath'] as String?,
    events: (json['events'] as List<dynamic>?)
        ?.map((e) => MyEvent.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_LessonToJson(_$_Lesson instance) {
  final val = <String, dynamic>{
    'id': instance.id,
    'uid': instance.uid,
    'name': instance.name,
    'description': instance.description,
    'course': instance.course,
    'category': instance.category,
    'subject': instance.subject,
    'unit': instance.unit,
    'chapter': instance.chapter,
    'upvotes': instance.upvotes,
    'duration': instance.duration,
    'images': instance.images,
    'audioUrl': instance.audioUrl,
    'eventsUrl': instance.eventsUrl,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('rawImagePaths', instance.rawImagePaths);
  writeNotNull('audioPath', instance.audioPath);
  writeNotNull('events', instance.events);
  return val;
}

_$_MyEvent _$_$_MyEventFromJson(Map<String, dynamic> json) {
  return _$_MyEvent(
    event: _$enumDecode(_$EventsEnumMap, json['e']),
    index: json['i'] as int?,
    time: json['t'] as int,
    color: json['c'] as String?,
    x: (json['x'] as num?)?.toDouble(),
    y: (json['y'] as num?)?.toDouble(),
  );
}

Map<String, dynamic> _$_$_MyEventToJson(_$_MyEvent instance) {
  final val = <String, dynamic>{
    'e': _$EventsEnumMap[instance.event],
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('i', instance.index);
  val['t'] = instance.time;
  writeNotNull('c', instance.color);
  val['x'] = instance.x;
  val['y'] = instance.y;
  return val;
}

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

const _$EventsEnumMap = {
  Events.changeImage: 'i',
  Events.pointerStart: 'p_s',
  Events.pointerMove: 'p_m',
  Events.pointerEnd: 'p_e',
  Events.pointerColor: 'p_c',
};
