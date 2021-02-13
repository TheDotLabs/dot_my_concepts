import 'package:flutter/material.dart';

abstract class AppDb {
  @mustCallSuper
  Future<void> initialise() {
    return Future.value();
  }

  Future<void> clear();
}
