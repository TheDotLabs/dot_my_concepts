import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:rxdart/rxdart.dart';

abstract class UserRepository {
  bool get hasUserSignedCla;

  bool get isTeacher;

  Future<Result> registerUser(MyUser user);

  MyUser? getLoggedInUser();

  BehaviorSubject<MyUser?> getLoggedInUserStream();

  Future<Result> logoutUser();

  bool getUserLoggedIn();

  void setUserLoggedIn(bool value);

  Future<void> saveSelectedCategory(String? id);

  Future<void> setUserSignedCla(bool value);

//  Future<List<User>> getUsers(String userName);
//
//  Future<List<User>> getUsersById(String ids);
//
//  Future<List<User>> getDummyUsers();
}
