import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';

abstract class AppDb {
  @mustCallSuper
  Future<void> initialise() {
    return Future.value();
  }

  Future<void> clear();

  Future<void> saveRawLesson(Lesson lesson);
}
