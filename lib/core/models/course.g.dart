// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'course.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Course _$_$_CourseFromJson(Map<String, dynamic> json) {
  return _$_Course(
    id: json['id'] as String,
    title: json['title'] as String,
    subtitle: json['subtitle'] as String,
    cover: json['cover'] as String,
    lessons: (json['lessons'] as List)?.map((e) => e as String)?.toList(),
  );
}

Map<String, dynamic> _$_$_CourseToJson(_$_Course instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'cover': instance.cover,
      'lessons': instance.lessons,
    };
