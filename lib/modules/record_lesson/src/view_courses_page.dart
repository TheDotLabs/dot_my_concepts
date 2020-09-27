import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/models/category.dart';

class ViewCoursesPage extends StatefulWidget {
  ViewCoursesPage({@required this.chapter});

  final MyChapter chapter;

  @override
  _ViewCoursesPageState createState() => _ViewCoursesPageState();
}

class _ViewCoursesPageState extends State<ViewCoursesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${widget.chapter.title}'),
      ),
      body: Center(
        child: Text('TODO'),
      ),
    );
  }

  Stream<List<Course>> _getCoursesStream() {
    return FirebaseFirestore.instance
        .collection('courses')
        .where('chapterId')
        .snapshots()
        .transform(
            StreamTransformer.fromHandlers(handleData: (snapshots, sink) {
      return sink.add(snapshots.docs
          .map((e) => Course.fromJson(e.data()).copyWith(id: e.id))
          .toList(growable: false));
    }));
  }
}
