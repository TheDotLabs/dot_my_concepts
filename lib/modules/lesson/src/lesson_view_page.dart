import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/modules/lesson/src/widgets/lesson_card.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';

import 'widgets/course_card.dart';

class LessonViewPage extends StatefulWidget {
  @override
  _LessonViewPageState createState() => _LessonViewPageState();
}

class _LessonViewPageState extends State<LessonViewPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          Container(
            height: 8,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey[50],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16,
            ),
            child: Text(
              'Newly Uploaded'.toUpperCase(),
              style: Theme.of(context).textTheme.overline,
              textAlign: TextAlign.center,
            ),
          ),
          StreamBuilder<List<Lesson>>(
              stream: _getStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    children: [
                      ...snapshot.data.map(
                        (e) => LessonCard(e),
                      ),
                    ],
                  );
                } else if (snapshot.hasError) {
                  return Center(
                    child: Text(snapshot.error),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
          Container(
            margin: EdgeInsets.only(top: 16),
            height: 8,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey[50],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 8.0,
              vertical: 16,
            ),
            child: Text(
              'POPULAR COURSES'.toUpperCase(),
              style: Theme.of(context).textTheme.overline,
              textAlign: TextAlign.center,
            ),
          ),
          StreamBuilder<List<Course>>(
            stream: _getCourseStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                return Container(
                  height: 180,
                  child: ListView(
                    padding: EdgeInsets.symmetric(
                      horizontal: 8,
                    ),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    children: [
                      ...snapshot.data.map(
                        (e) => CourseCard(e),
                      ),
                    ],
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error),
                );
              } else {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }
            },
          ),
          Container(
            margin: EdgeInsets.only(top: 16),
            height: 8,
            width: MediaQuery.of(context).size.width,
            color: Colors.blueGrey[50],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 48.0),
            child: Text(
              '-- Prefer Quality Over Quantity --',
              style: TextStyle(
                color: Colors.grey,
                fontStyle: FontStyle.italic,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          )
        ],
      ),
    );
  }

  Stream<List<Lesson>> _getStream() {
    return FirebaseFirestore.instance
        .collection('lessons')
        .snapshots()
        .transform(
            StreamTransformer.fromHandlers(handleData: (snapshots, sink) {
      return sink.add(snapshots.docs
          .map((e) => Lesson.fromJson(e.data()).copyWith(id: e.id))
          .toList(growable: false));
    }));
  }

  Stream<List<Course>> _getCourseStream() {
    return FirebaseFirestore.instance
        .collection('courses')
        .snapshots()
        .transform(
            StreamTransformer.fromHandlers(handleData: (snapshots, sink) {
      return sink.add(snapshots.docs
          .map((e) => Course.fromJson(e.data()).copyWith(id: e.id))
          .toList(growable: false));
    }));
  }
}
