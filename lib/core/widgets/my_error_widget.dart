import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/utils/constants.dart';

class MyErrorWidget extends StatelessWidget {
  final dynamic error;

  const MyErrorWidget(this.error);

  @override
  Widget build(BuildContext context) {
    return Text(error?.toString() ?? Constants.somethingWentWrong);
  }
}
