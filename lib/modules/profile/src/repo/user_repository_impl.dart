import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:rxdart/rxdart.dart';

class FirebaseUserRepository implements UserRepository {
  FirebaseUserRepository({
    @required this.prefHelper,
    @required this.firestore,
  }) {
    init();
  }

  final AppPrefs prefHelper;
  final FirebaseFirestore firestore;

  static const _prefsUserLogin = "prefsUserLogin";
  final _userSubject = BehaviorSubject<MyUser>.seeded(null);

  @override
  Future<Result> registerUser(MyUser user) async {
    try {
      final userDoc = await firestore.collection('users').doc(user.id).get();
      if (userDoc.exists) {
        await firestore.collection('users').doc(user.id).update({
          'updatedAt': DateTime.now().millisecondsSinceEpoch ~/ 1000,
        });
        setUserLoggedIn(true);
        return Result.success();
      } else {
        final epoch = DateTime.now().millisecondsSinceEpoch ~/ 1000;
        await firestore.collection('users').doc(user.id).set({
          ...user.toJson(),
          'createdAt': epoch,
          'updatedAt': epoch,
        });
        setUserLoggedIn(true);
        init();
        return Result.success(null);
      }
    } catch (e, s) {
      logger.e(e, s);
      return Result.error('${e.message}');
    }
  }

  Future<void> init() async {
    try {
      final firebaseUser = FirebaseAuth.instance.currentUser;
      if (firebaseUser != null) {
        firestore
            .collection('users')
            .doc(firebaseUser.uid)
            .snapshots()
            .listen((event) async {
          if (event != null) {
            _userSubject.add(MyUser.fromJson(event.data()));
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
  BehaviorSubject<MyUser> getLoggedInUserStream() {
    return _userSubject.stream;
    /*try {
      final userId = FirebaseAuth.instance.currentUser?.uid;
      if (userId == null) {
        throw Exception('No logged in user found');
      }
      final result = firestore
          .collection('users')
          .doc(userId)
          .snapshots()
          .transform<MyUser>(
              StreamTransformer.fromHandlers(handleData: (data, sink) {
            sink.add(MyUser.fromJson(data.data()));
          }))
          .asBroadcastStream()
          .shareValue();
      return result;
    } catch (e, s) {
      logger.e(e, s);
      logoutUser();
      stream.sink.addError(e);
      return stream;
    }*/
  }

  @override
  Future<Result<MyUser>> getLoggedInUser(String userId) {
    return Future.value(Result.success(_userSubject.value));
  }

  @override
  Future<Result> logoutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      await prefHelper.clear();

      return Result.success(null);
    } catch (e, s) {
      logger.e(e, s);
      return Result.error('${e.message}');
    }
  }

  @override
  bool getUserLoggedIn() {
    return prefHelper.getBool(_prefsUserLogin) ?? false;
  }

  @override
  void setUserLoggedIn(bool value) {
    prefHelper.setBool(_prefsUserLogin, value);
  }

  @override
  Future<void> saveSelectedCategory(String id) async {
    try {
      await firestore.collection('users').doc(_userSubject.value.id).update({
        'selectedCategory': id,
        'updatedAt': DateTime.now().millisecondsSinceEpoch ~/ 1000,
      });
    } catch (e, s) {
      logger.e(e, s);
    }
  }
}
