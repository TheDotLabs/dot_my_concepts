import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';

class RecordLessonBloc extends BaseBloc {
  late Lesson currentLesson;

  @override
  void dispose() {}

  void createNewLesson({String? name, String? description, required MyCourse course}) {
    logger.i(
      'Creating new lesson: {name: $name, description: $description, course: $course}...',
    );

    final uid = FirebaseFirestore.instance.collection('lessons').doc().id;
    currentLesson = Lesson(
      id: uid,
      name: name,
      description: description,
      category: course.categoryId,
      chapter: course.chapterId,
      unit: course.unitId,
    );

    logger.i('Created new lesson: ${currentLesson.toString()}');
  }

  Future<Result<MyCourse>> createNewCourse({
    String? name,
    String? description,
    required MyCategory category,
    required MySubject subject,
    required MyUnit unit,
    required MyChapter chapter,
  }) async {
    try {
      final user = injector<UserRepository>().getLoggedInUser()!;
      final doc = FirebaseFirestore.instance.collection('courses').doc();
      final course = MyCourse(
        id: doc.id,
        title: name,
        subtitle: description,
        userId: user.id,
        categoryId: category.id,
        subjectId: subject.id,
        unitId: unit.id,
        chapterId: chapter.id,
      );
      await doc.set(
        course.toJson(),
      );
      return Result<MyCourse>.success(data: course);
    } catch (e, s) {
      logger.e(e, s);
      return Result<MyCourse>.failure(reason: e.toString());
    }
  }
}
