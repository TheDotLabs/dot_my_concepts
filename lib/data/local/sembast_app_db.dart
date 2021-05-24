import 'dart:convert';

import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sembast/sembast.dart';
import 'package:sembast/sembast_io.dart';

import 'app_db.dart';

class SembastAppDb extends AppDb {
  Database? db;
  final lessonStore = StoreRef.main();

  @override
  Future<void> initialise() async {
    try {
      // if (isWeb) {
      //  // final factory = databaseFactoryWeb;
      //   db = await factory.openDatabase('fa_flutter_mt_database');
      // } else

      final dir = await getApplicationDocumentsDirectory();
      await dir.create(recursive: true);
      final dbPath = join(dir.path, 'fa_flutter_mt_database.db');
      db = await databaseFactoryIo.openDatabase(dbPath);

      await super.initialise();
    } catch (e, s) {
      logger.e(e, s);
      throw Exception("Error in initialising sembast Db");
    }
  }

  @override
  Future<void> saveRawLesson(Lesson lesson) async {
    try {
      final result =
          await lessonStore.record(lesson.id).put(db!, jsonEncode(lesson));
      return result;
    } catch (e, s) {
      logger.e(e, s);
      rethrow;
    }
  }

  @override
  Future<void> clear() async {
    logger.i("Clearing sembast app db...");
    // ...
    logger.i('Clearing sembast app successful');
  }
}
