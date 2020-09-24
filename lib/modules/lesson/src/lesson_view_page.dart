import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/play_lesson/src/play_lesson_page.dart';
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
                children: [
                  ...snapshot.data.map(
                    (e) => Card(
                      elevation: 1,
                      child: GestureDetector(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => PlayLessonPage(
                                lessonId: e.id,
                              ),
                            ),
                          );
                        },
                        child: Column(
                          children: [
                            Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: e.images == null
                                  ? Container()
                                  : CachedNetworkImage(
                                      imageUrl: e.images[0],
                                    ),
                            ),
                            Divider(
                              height: 1,
                            ),
                            ListTile(
                              title: Text("${e.name ?? "---"}"),
                              subtitle: Text("${e.description ?? "---"}"),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
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
