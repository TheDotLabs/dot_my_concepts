import 'package:flutter/material.dart';

extension ColorX on Color {
  String hexCode() {
    return '#${this.value.toRadixString(16)}';
  }
}
