import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/circular_loading.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/create_lesson_page.dart';

import 'nested_course_creation.dart';
import 'widgets/tag_row.dart';

class SelectCoursePage extends StatefulWidget {
  @override
  _SelectCoursePageState createState() => _SelectCoursePageState();

  const SelectCoursePage({
    this.createCourse = false,
  });

  final bool createCourse;
}

class _SelectCoursePageState extends State<SelectCoursePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Your Course'),
      ),
      body: StreamBuilder<List<MyCourse>>(
        stream: _getStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final list = snapshot.data;
            return Container(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  vertical: 0,
                ),
                children: [
                  ...ListTile.divideTiles(context: context, tiles: [
                    ...list.map(
                      (e) => ListTile(
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        /*leading: CachedNetworkImage(
                          imageUrl: e.image,
                          height: 40,
                          width: 40,
                        ),*/
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(
                          e.title,
                        ),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(e.subtitle ?? "--"),
                            Container(
                              child: TagsRow(e),
                              margin: EdgeInsets.only(top: 8),
                            ),
                          ],
                        ),
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => CreateLessonPage(
                                course: e,
                              ),
                            ),
                          );
                        },
                      ),
                    )
                  ]).toList(),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 32),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        RaisedButton(
                          onPressed: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => NestedCourseCreation(),
                              ),
                            );
                          },
                          child: Text('Add New Course'),
                        ),
                      ],
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
              child: CircularLoading(),
            );
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<MyCourse>> _getStream() {
    return FirebaseFirestore.instance
        .collection('courses')
        .where(
          'userId',
          isEqualTo: injector<UserRepository>().getLoggedInUser().id,
        )
        .snapshots()
        .transform(
      StreamTransformer.fromHandlers(
        handleData: (snapshot, sink) {
          final list = snapshot.docs
              .map((e) => MyCourse.fromJson(e.data()).copyWith(id: e.id))
              .toList(growable: false);
          return sink.add(list);
        },
      ),
    );
  }
}
