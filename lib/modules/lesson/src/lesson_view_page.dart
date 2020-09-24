import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/lesson/src/widgets/lesson_card.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';

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
      body: StreamBuilder<List<Lesson>>(
          stream: _getStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16,
                    ),
                    child: Text(
                      'Newly Uploaded'.toUpperCase(),
                      style: Theme.of(context).textTheme.overline.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
                  ...snapshot.data.map(
                    (e) => LessonCard(e),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 16,
                    ),
                    child: Text(
                      'POPULAR COURSES'.toUpperCase(),
                      style: Theme.of(context).textTheme.overline.copyWith(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                      textAlign: TextAlign.start,
                    ),
                  ),
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
}
