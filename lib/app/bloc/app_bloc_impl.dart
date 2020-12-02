import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/models/category.dart';

import 'base/app_bloc.dart';

class AppBlocImpl extends AppBloc {
  final AppPrefs appPrefs;

  static const prefsSelectedCategory = "selected_category";

  AppBlocImpl({@required this.appPrefs});

  @override
  void onCategorySelection(Category category) {
    appPrefs.setString(prefsSelectedCategory, category.id);
    notifyListeners();
  }

  @override
  String get selectedCategory => appPrefs.getString(prefsSelectedCategory);
}
