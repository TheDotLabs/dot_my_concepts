import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    required this.prefHelper,
    required this.firestore,
  });

  final AppPrefs? prefHelper;
  final FirebaseFirestore? firestore;

  static const _prefsUserLogin = "prefsUserLogin";
  final _userSubject = BehaviorSubject<MyUser?>.seeded(null);

  Future<void> init() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        final userDoc =
            await firestore!.collection('users').doc(firebaseUser.uid).get();
        _userSubject.add(MyUser.fromJson(userDoc.data()!));

        firestore!
            .collection('users')
            .doc(firebaseUser.uid)
            .snapshots()
            .listen((event) async {
          if (event != null) {
            _userSubject.add(MyUser.fromJson(event.data()!));
            /* final _firebaseMessaging = FirebaseMessaging();
          _firebaseMessaging.setAutoInitEnabled(true);
          _fcmToken = await _firebaseMessaging.getToken();
          await firestore
              .collection('users')
              .document(firebaseUser.uid)
              .updateData({'fcmToken': _fcmToken});*/
          } else
            _userSubject.add(null);
        });
      } else {
        logger.i('Firebase: User is null');
      }
    } catch (e, s) {
      logger.e(e, s);
      _userSubject.addError(e);
    }
  }

  @override
  Future<Result> registerUser(MyUser user) async {
    try {
      final userDoc = await firestore!.collection('users').doc(user.id).get();
      if (userDoc.exists) {
        await firestore!.collection('users').doc(user.id).update({
          'updatedAt': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        });
      } else {
        final epoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await firestore!.collection('users').doc(user.id).set({
          ...user.toJson(),
          'createdAt': epoch,
          'updatedAt': epoch,
        });
      }
      setUserLoggedIn(true);
      await init();
      return Result.success(data: null);
    } catch (e, s) {
      logger.e(e, s);
      return Result.failure(reason: '${e.toString()}');
    }
  }

  @override
  BehaviorSubject<MyUser?> getLoggedInUserStream() {
    return _userSubject.stream as BehaviorSubject<MyUser?>;
  }

  @override
  MyUser? getLoggedInUser() {
    return _userSubject.value;
  }

  @override
  Future<Result> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      await prefHelper!.clear();

      return Result.success(data: null);
    } catch (e, s) {
      logger.e(e, s);
      return Result.failure(reason: '${e.toString()}');
    }
  }

  @override
  bool getUserLoggedIn() {
    return prefHelper!.getBool(_prefsUserLogin) ?? false;
  }

  @override
  void setUserLoggedIn(bool value) {
    prefHelper!.setBool(_prefsUserLogin, value);
  }

  @override
  Future<void> saveSelectedCategory(String? id) async {
    try {
      _userSubject.add(_userSubject.value!.copyWith(selectedCategory: id));
      await firestore!.collection('users').doc(_userSubject.value!.id).update({
        'selectedCategory': id,
        'updatedAt': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      });
    } catch (e, s) {
      logger.e(e, s);
    }
  }

  @override
  Future<void> setUserSignedCla(bool value) async {
    try {
      await firestore!.collection('users').doc(_userSubject.value!.id).update({
        'teaching': {
          ..._userSubject.value!.teaching?.toJson() ?? {},
          'hasSignedCLA': true,
        },
        'updatedAt': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      });
    } catch (e, s) {
      logger.e(e, s);
    }
  }

  @override
  bool get hasUserSignedCla =>
      _userSubject.value!.teaching?.hasSignedCLA ?? false;

  @override
  bool get isTeacher => hasUserSignedCla;
}
