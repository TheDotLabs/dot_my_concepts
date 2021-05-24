import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_record_lesson/app/bloc/app_bloc_impl.dart';
import 'package:flutter_record_lesson/app/bloc/base/app_bloc.dart';
import 'package:flutter_record_lesson/data/local/app_db.dart';
import 'package:flutter_record_lesson/data/local/sembast_app_db.dart';
import 'package:flutter_record_lesson/data/repo/google_login_repository.dart';
import 'package:flutter_record_lesson/modules/common/src/bloc/record_lesson_bloc.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:get_it/get_it.dart';
import 'package:google_sign_in/google_sign_in.dart';

// ignore_for_file: cascade_invocations
GetIt locator = GetIt.instance;

enum Flavor {
  debug,
}

class Injector {
  factory Injector() => _singleton;

  Injector._internal();

  static final Injector _singleton = Injector._internal();

  Future<void> configure(Flavor flavor) async {
    try {
      if (isMobile) {
        await Firebase.initializeApp();
      }
      await _initHelpers();
      await _initBlocs();
    } catch (e, s) {
      logger.e(e, s);
      rethrow;
    }
  }

  Future<void> _initHelpers() async {
    //await Executor().warmUp();

    locator.registerSingleton<AppLog>(
      logger,
    );

/*    // NetworkInfo
    injector.registerLazySingleton<NetworkInfo>(
      () => NetworkInfoImpl(DataConnectionChecker()),
    );*/

    /// SharedPreferences
    final appsPrefs = SharedAppPrefs();
    await appsPrefs.initialise();
    locator.registerSingleton<AppPrefs>(appsPrefs);
    //final appPrefsHelper = AppPrefsHelperImpl(appPrefs: injector());
    //injector.registerSingleton<AppPrefsHelper>(appPrefsHelper);

    // FirestoreInstance
    locator.registerLazySingleton<FirebaseFirestore>(
        () => FirebaseFirestore.instance);

    // GoogleLoginRepository
    locator.registerLazySingleton<GoogleLoginRepository>(
      () => GoogleLoginRepository(
        googleSignIn: GoogleSignIn(),
      ),
    );

    // UserRepository
    final repo = FirebaseUserRepository(
      prefHelper: locator(),
      firestore: locator(),
    );
    await repo.init();
    locator.registerLazySingleton<UserRepository>(() => repo);

    /// DbHelper;
    final appDb = SembastAppDb();
    await appDb.initialise();
    locator.registerSingleton<AppDb>(appDb);
  }

  Future<void> _initBlocs() async {
    // ApplicationBloc
    final appBloc = AppBlocImpl(
      appPrefs: locator(),
      firestore: locator(),
    );
    //await appBloc.init();
    locator.registerSingleton<AppBloc>(
      appBloc,
    );

    // GoogleLoginRepository
    locator.registerLazySingleton<RecordingLessonBloc>(
      () => RecordingLessonBloc(userRepository: locator()),
    );
  }
}
