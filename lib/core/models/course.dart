import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
abstract class MyCourse with _$MyCourse {
  factory MyCourse({
    String? id,
    String? userId,
    String? title,
    String? subtitle,
    String? cover,
    String? categoryId,
    String? subjectId,
    String? chapterId,
    String? unitId,
    List<String>? lessons,
  }) = _MyCourse;

  factory MyCourse.fromJson(Map<String, dynamic> json) =>
      _$MyCourseFromJson(json);
}
