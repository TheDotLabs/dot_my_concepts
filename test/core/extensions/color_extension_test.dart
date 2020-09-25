import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/extensions/color_extension.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('correct hexCode for a color', () {
    final color = Colors.blue.withOpacity(1.0);
    expect(color.hexCode(), '#ff2196f3');
  });
}
