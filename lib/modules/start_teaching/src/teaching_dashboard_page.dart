import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/category_page.dart';

class TeachingDashboardPage extends StatefulWidget {
  @override
  _TeachingDashboardPageState createState() => _TeachingDashboardPageState();
}

class _TeachingDashboardPageState extends State<TeachingDashboardPage> {
  final Stream<List<Course>> _coursesStream = FirebaseFirestore.instance
      .collection('courses')
      .where('userId',
          isEqualTo: injector<UserRepository>().getLoggedInUser().id)
      .snapshots()
      .transform(
    StreamTransformer.fromHandlers(
      handleData: (snapshots, sink) {
        return sink.add(
          snapshots.docs
              .map((e) => Course.fromJson(e.data()).copyWith(id: e.id))
              .toList(growable: false),
        );
      },
    ),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SectionDivider(),
            SectionHeader('Your Dashboard'),
            ListTile(
              title: Text(
                'Total Courses',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              trailing: StreamBuilder<List<Course>>(
                  stream: _getUserCoursesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null)
                      return Text(
                        '${snapshot.data.length}',
                      );
                    else
                      return Text('--');
                  }),
            ),
            ListTile(
              title: Text(
                'Total Lessons',
                style: TextStyle(
                  fontSize: 14,
                ),
              ),
              trailing: StreamBuilder<List<Course>>(
                  stream: _getUserCoursesStream(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData && snapshot.data != null) {
                      return Text(
                        '${snapshot.data.fold<int>(0, (previousValue, element) => previousValue + (element?.lessons?.length ?? 0))}',
                      );
                    } else
                      return Text('--');
                  }),
            ),
            SizedBox(
              height: 12,
            ),
            SectionDivider(),
            SectionHeader('NEW Lesson'),
            Text(
              'Add a lesson to your existing course',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    buttonTheme: ButtonThemeData(
                      height: 48,
                      textTheme: ButtonTextTheme.primary,
                    ),
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoryPage(),
                        ),
                      );
                    },
                    child: Text('Add New Lesson'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            SectionDivider(),
            SectionHeader('New Course'),
            Text(
              'Create a new course and lessons',
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Theme(
                  data: Theme.of(context).copyWith(
                    buttonTheme: ButtonThemeData(
                      height: 48,
                      textTheme: ButtonTextTheme.primary,
                    ),
                  ),
                  child: RaisedButton(
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => CategoryPage(),
                        ),
                      );
                    },
                    child: Text('Start New Course'),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 24,
            ),
            SectionDivider(),
          ],
        ),
      ),
    );
  }

  Stream<List<Course>> _getUserCoursesStream() {
    return _coursesStream;
  }
}
