// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_MyCategory _$_$_MyCategoryFromJson(Map<String, dynamic> json) {
  return _$_MyCategory(
    id: json['id'] as String,
    title: json['title'] as String?,
    description: json['description'] as String?,
    image: json['image'] as String?,
    subjects: (json['subjects'] as List<dynamic>?)
        ?.map((e) => MySubject.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_MyCategoryToJson(_$_MyCategory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'image': instance.image,
      'subjects': instance.subjects,
    };

_$_MySubject _$_$_MySubjectFromJson(Map<String, dynamic> json) {
  return _$_MySubject(
    id: json['id'] as String,
    title: json['title'] as String?,
    description: json['description'] as String?,
    units: (json['units'] as List<dynamic>?)
        ?.map((e) => MyUnit.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_MySubjectToJson(_$_MySubject instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'units': instance.units,
    };

_$_MyUnit _$_$_MyUnitFromJson(Map<String, dynamic> json) {
  return _$_MyUnit(
    id: json['id'] as String,
    title: json['title'] as String?,
    description: json['description'] as String?,
    chapters: (json['chapters'] as List<dynamic>?)
        ?.map((e) => MyChapter.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$_$_MyUnitToJson(_$_MyUnit instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'chapters': instance.chapters,
    };

_$_MyChapter _$_$_MyChapterFromJson(Map<String, dynamic> json) {
  return _$_MyChapter(
    id: json['id'] as String,
    title: json['title'] as String?,
    description: json['description'] as String?,
  );
}

Map<String, dynamic> _$_$_MyChapterToJson(_$_MyChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
