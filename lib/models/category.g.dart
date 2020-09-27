// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Category _$_$_CategoryFromJson(Map<String, dynamic> json) {
  return _$_Category(
    id: json['id'] as String,
    title: json['title'] as String,
    description: json['description'] as String,
    image: json['image'] as String,
    subjects: (json['subjects'] as List)
        ?.map((e) =>
            e == null ? null : MySubject.fromJson(e as Map<String, dynamic>))
        ?.toList(),
  );
}

Map<String, dynamic> _$_$_CategoryToJson(_$_Category instance) =>
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
    title: json['title'] as String,
    description: json['description'] as String,
    units: (json['units'] as List)
        ?.map((e) =>
            e == null ? null : MyUnit.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
    title: json['title'] as String,
    description: json['description'] as String,
    chapters: (json['chapters'] as List)
        ?.map((e) =>
            e == null ? null : MyChapter.fromJson(e as Map<String, dynamic>))
        ?.toList(),
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
    title: json['title'] as String,
    description: json['description'] as String,
  );
}

Map<String, dynamic> _$_$_MyChapterToJson(_$_MyChapter instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
    };
