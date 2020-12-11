import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/profile/src/repo/user_repository.dart';

import 'base/app_bloc.dart';

class AppBlocImpl extends AppBloc {
  final AppPrefs appPrefs;

  static const prefsSelectedCategory = "selected_category";

  AppBlocImpl({
    @required this.appPrefs,
    this.firestore,
  });

  final FirebaseFirestore firestore;

  @override
  void onCategorySelection(Category category) {
    appPrefs.setString(prefsSelectedCategory, category.id);
    notifyListeners();
    injector<UserRepository>().saveSelectedCategory(category.id);
  }

  @override
  String get selectedCategory => appPrefs.getString(prefsSelectedCategory);
}
