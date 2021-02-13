import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';

class RecordLessonBloc extends BaseBloc {
  Lesson currentLesson;

  @override
  void dispose() {}

  void createNewLesson({String name, String description}) {
    logger.i(
      'Creating new lesson: {name: $name, description: $description}...',
    );

    final uid = FirebaseFirestore.instance.collection('lessons').doc().id;
    currentLesson = Lesson(
      id: uid,
      name: name,
      description: description,
    );

    logger.i('Created new lesson: ${currentLesson.toString()}');
  }

  Future<Result<MyCourse>> createNewCourse({
    String name,
    String description,
    MyCategory category,
    MySubject subject,
    MyUnit unit,
    MyChapter chapter,
  }) async {
    try {
      final user = injector<UserRepository>().getLoggedInUser();
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
      return Result<MyCourse>.success(course);
    } catch (e, s) {
      logger.e(e, s);
      return Result<MyCourse>.error(e.toString());
    }
  }
}
