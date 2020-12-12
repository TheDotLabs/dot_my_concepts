import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';
import 'package:flutter_record_lesson/core/widgets/no_item_found.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/circular_loading.dart';

class ViewCoursesPage extends StatefulWidget {
  ViewCoursesPage({
    @required this.category,
    @required this.subject,
    @required this.unit,
    @required this.chapter,
  });

  final Category category;
  final MySubject subject;
  final MyUnit unit;
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
      body: StreamBuilder<List<Course>>(
        stream: _getCoursesStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null)
            return snapshot.data.isNotEmpty
                ? ListView(
                    padding: EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 8,
                    ),
                    children: [
                      ...snapshot.data.map(
                        (e) => _CourseCard(
                          course: e,
                        ),
                      ),
                    ],
                  )
                : Center(
                    child: NoItemFound(msg: 'No course found'),
                  );
          else if (snapshot.hasError) {
            return Center(
              child: Text(snapshot.error),
            );
          } else {
            return Center(
              child: CircularLoading(),
            );
          }
        },
      ),
    );
  }

  Stream<List<Course>> _getCoursesStream() {
    return FirebaseFirestore.instance
        .collection('courses')
        .where(
          'category',
          isEqualTo: widget.category.id,
        )
        .where(
          'subject',
          isEqualTo: widget.subject.id,
        )
        .where(
          'unit',
          isEqualTo: widget.unit.id,
        )
        .where(
          'chapter',
          isEqualTo: widget.chapter.id,
        )
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
  }
}

class _CourseCard extends StatelessWidget {
  _CourseCard({this.course});

  final Course course;

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 4),
        child: GestureDetector(
          onTap: () {
            /*Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlayLessonPage(
                  lessonId: lesson.id,
                ),
              ),
            );*/
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CachedNetworkImage(
                imageUrl: course.cover,
                fit: BoxFit.cover,
                height: MediaQuery.of(context).size.height / 4,
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  course.title,
                  style: Theme.of(context).textTheme.bodyText1.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
