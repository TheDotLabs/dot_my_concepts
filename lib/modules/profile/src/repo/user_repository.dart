import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:rxdart/rxdart.dart';

abstract class UserRepository {
  Future<Result> registerUser(MyUser user);

  Future<Result<MyUser>> getLoggedInUser(String userId);

  BehaviorSubject<MyUser> getLoggedInUserStream();

  Future<Result> logoutUser();

  bool getUserLoggedIn();

  void setUserLoggedIn(bool value);

  Future<void> saveSelectedCategory(String id);

//  Future<List<User>> getUsers(String userName);
//
//  Future<List<User>> getUsersById(String ids);
//
//  Future<List<User>> getDummyUsers();
}
