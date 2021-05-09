import 'package:freezed_annotation/freezed_annotation.dart';

part 'category.freezed.dart';
part 'category.g.dart';

@freezed
abstract class MyCategory with _$MyCategory {
  factory MyCategory({
    @Default("0") String? id,
    String? title,
    String? description,
    String? image,
    List<MySubject>? subjects,
  }) = _MyCategory;

  factory MyCategory.fromJson(Map<String, dynamic> json) =>
      _$MyCategoryFromJson(json);
}

@freezed
abstract class MySubject with _$MySubject {
  factory MySubject({
    @JsonKey(defaultValue: 0) String? id,
    String? title,
    String? description,
    List<MyUnit>? units,
  }) = _MySubject;

  factory MySubject.fromJson(Map<String, dynamic> json) =>
      _$MySubjectFromJson(json);
}

@freezed
abstract class MyUnit with _$MyUnit {
  factory MyUnit({
    @JsonKey(defaultValue: 0) String? id,
    String? title,
    String? description,
    List<MyChapter>? chapters,
  }) = _MyUnit;

  factory MyUnit.fromJson(Map<String, dynamic> json) => _$MyUnitFromJson(json);
}

@freezed
abstract class MyChapter with _$MyChapter {
  factory MyChapter({
    @JsonKey(defaultValue: 0) String? id,
    String? title,
    String? description,
  }) = _MyChapter;

  factory MyChapter.fromJson(Map<String, dynamic> json) =>
      _$MyChapterFromJson(json);
}
