import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/models/category.dart';

abstract class AppBloc extends ChangeNotifier {
  void onCategorySelection(Category category);
  String get selectedCategory;
}
