import 'package:freezed_annotation/freezed_annotation.dart';

part 'course.freezed.dart';
part 'course.g.dart';

@freezed
abstract class MyCourse with _$MyCourse {
  factory MyCourse({
    required String id,
    required String userId,
    required String categoryId,
    required String subjectId,
    required String chapterId,
    required String unitId,
    String? title,
    String? subtitle,
    String? cover,
    List<String>? lessons,
  }) = _MyCourse;

  factory MyCourse.fromJson(Map<String, dynamic> json) =>
      _$MyCourseFromJson(json);
}
