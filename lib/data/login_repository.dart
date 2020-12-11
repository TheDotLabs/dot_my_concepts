import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';

abstract class LoginRepository {
  final _firebaseAuth = FirebaseAuth.instance;

  @protected
  Future<User> getFirebaseUser(AuthCredential credential) async {
    return (await _firebaseAuth.signInWithCredential(credential)).user;
  }

  @protected
  Future<Result> registerUser(MyUser user) =>
      injector<UserRepository>().registerUser(user);

  Future<Result> login();

  Future<Result> loginWithCredentials();

  Future<Result> logout();

  Future<bool> isLoggedIn();
}

extension LoginProviderX on LoginProvider {
  String get name {
    switch (this) {
      case LoginProvider.google:
        return 'Google';

      default:
        throw Exception('Not a valid login provider');
    }
  }
}

enum LoginProvider {
  google,
}
