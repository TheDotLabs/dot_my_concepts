import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/lesson/src/select_unit_page.dart';
import 'package:flutter_record_lesson/modules/lesson/src/widgets/lesson_card.dart';
import 'package:flutter_record_lesson/modules/lesson/src/widgets/teacher_card.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/view_courses_page.dart';

import 'widgets/course_card.dart';

class FeedPage extends StatefulWidget {
  @override
  _FeedPageState createState() => _FeedPageState();
}

class _FeedPageState extends State<FeedPage>
    with AutomaticKeepAliveClientMixin {
  static const String _categoryId = 'kmr68ONGNU9tNBDgpMHD';

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
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
                'Start Learning'.toUpperCase(),
                style: Theme.of(context).textTheme.overline,
                textAlign: TextAlign.center,
              ),
            ),
            StreamBuilder<Category>(
                stream: _getCategoryStream(),
                builder: (context, snapshot) {
                  if (snapshot.hasData && snapshot.data != null) {
                    return Container(
                      padding: EdgeInsets.fromLTRB(4, 0, 4, 8),
                      child: Column(
                        children: [
                          ...snapshot.data.subjects.map(
                            (subject) => ListTile(
                              dense: true,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                              ),
                              title: Text(
                                subject.title,
                                style: TextStyle(
                                  fontSize: 14,
                                ),
                              ),
                              trailing: Text(
                                '1243',
                                style: Theme.of(context).textTheme.caption,
                              ),
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => SelectUnitPage(
                                      category: snapshot.data,
                                      subject: subject,
                                      onTap: _onChapterSelect,
                                    ),
                                  ),
                                );
                              },
                            ),
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
                }),
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
                    return Container(
                      height: 180,
                      child: ListView(
                        padding: EdgeInsets.symmetric(
                          horizontal: 8,
                        ),
                        scrollDirection: Axis.horizontal,
                        physics: NeverScrollableScrollPhysics(),
                        children: [
                          ...snapshot.data.map(
                            (e) => LessonCard(e),
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
              padding: const EdgeInsets.symmetric(
                horizontal: 8.0,
                vertical: 16,
              ),
              child: Text(
                'ELITE TEACHERS'.toUpperCase(),
                style: Theme.of(context).textTheme.overline,
                textAlign: TextAlign.center,
              ),
            ),
            StreamBuilder<List<Course>>(
              stream: _getTeachersStream(),
              builder: (context, snapshot) {
                if (snapshot.hasData && snapshot.data != null) {
                  return Container(
                    height: 150,
                    child: ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 8,
                      ),
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      children: [
                        ...snapshot.data.map(
                          (e) => TeacherCard(e),
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

  Stream<List<Course>> _getTeachersStream() {
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

  Stream<Category> _getCategoryStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
      final list = snapshot.docs
          .map((e) => Category.fromJson(e.data()).copyWith(id: e.id))
          .toList(growable: false);
      return sink.add(list.firstWhere((element) => element.id == _categoryId));
    }));
  }

  void _onChapterSelect({
    Category category,
    MySubject subject,
    MyUnit unit,
    MyChapter chapter,
  }) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ViewCoursesPage(
          category: category,
          subject: subject,
          unit: unit,
          chapter: chapter,
        ),
      ),
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
