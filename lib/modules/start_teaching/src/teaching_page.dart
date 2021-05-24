import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/app/bloc/base/app_bloc.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/start_teaching/src/start_teaching_page.dart';
import 'package:flutter_record_lesson/modules/start_teaching/src/teaching_dashboard_page.dart';

class TeachingPage extends StatefulWidget {
  @override
  _TeachingPageState createState() => _TeachingPageState();
}

class _TeachingPageState extends State<TeachingPage> {
  @override
  Widget build(BuildContext context) {
    return locator<AppBloc>().isTeacher
        ? TeachingDashboardPage()
        : StartTeachingPage();
  }
}
