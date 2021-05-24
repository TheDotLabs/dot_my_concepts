import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class Bloc extends BaseBloc {
  Bloc(this.lessonId);

  late String audioPath;
  late Lesson _lesson;
  final String lessonId;

  Lesson? get lesson => _lesson;
  int? lastEventTime = 0;

  Future<bool> init(String lessonId) async {
    try {
      await _loadAudio();
      final events = await _loadEvents();

      _lesson = await fetchLesson();
      _lesson = _lesson.copyWith(events: events);

      // lesson!.images!.forEach((element) {
      //   precacheImage(
      //     CachedNetworkImageProvider(element),
      //     context,
      //   );
      // });
      return true;
    } catch (e, s) {
      logger.e(e, s);
      rethrow;
    }
  }

  Future<Lesson> fetchLesson() async {
    final doc = await FirebaseFirestore.instance.doc('lessons/$lessonId').get();
    return Lesson.fromJson(doc.data()!).copyWith(
      id: doc.id,
    );
  }

  Future<void> _loadAudio() async {
    final directory = await getTemporaryDirectory();
    final path = p.join(directory.path, '$lessonId/audio.aac');
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    final storageReference = FirebaseStorage.instance.ref(
      'lessons/$lessonId/audio.aac',
    );

    await storageReference.writeToFile(file);

    audioPath = path;
  }

  Future<List<MyEvent>> _loadEvents() async {
    final directory = await getTemporaryDirectory();
    final path = p.join(directory.path, '$lessonId/events.json');
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
    }
    await FirebaseStorage.instance
        .ref(
          'lessons/$lessonId/events.json',
        )
        .writeToFile(file);

    final raw = file.readAsStringSync();
    final rawString = jsonDecode(raw);
    final events = ((rawString as Map)['events'] as List)
        .map((e) => MyEvent.fromJson(e))
        .cast<MyEvent>()
        .toList();
    return events;
  }

  List<MyEvent> getNextList({int? fromTime}) {
    final list = getEvents()
        .where((element) =>
            element.time! > (fromTime ?? lastEventTime!) &&
            element.time! < (fromTime ?? lastEventTime)! + 5000)
        .toList();
    if (list.isNotEmpty) {
      lastEventTime = list.last.time ?? getEvents().last.time;
    }
    return list;
  }

  List<MyEvent> getEvents() {
    return lesson!.events!;
  }

  @override
  void dispose() {}
}
