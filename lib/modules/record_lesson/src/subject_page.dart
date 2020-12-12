import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/widgets/no_item_found.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/circular_loading.dart';
import 'package:flutter_record_lesson/modules/lesson/src/select_unit_page.dart';
import 'package:rxdart/rxdart.dart';

import 'record_lesson.dart';

class SubjectPage extends StatefulWidget {
  final Category category;

  SubjectPage({this.category});

  @override
  _SubjectPageState createState() => _SubjectPageState();
}

class _SubjectPageState extends State<SubjectPage> {
  final _subject = BehaviorSubject<List<MySubject>>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Subject'),
      ),
      body: StreamBuilder<List<MySubject>>(
        stream: _getStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final list = snapshot.data;
            return Container(
              child: list.isNotEmpty
                  ? ListView(
                      padding: EdgeInsets.symmetric(
                        horizontal: 4,
                        vertical: 8,
                      ),
                      children: [
                        ...list.map(
                          (e) => ListTile(
                            dense: true,
                            title: Text(e.title),
                            trailing: Icon(Icons.keyboard_arrow_right),
                            subtitle: e.description != null
                                ? Text(e.description)
                                : null,
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SelectUnitPage(
                                    subject: e,
                                    category: widget.category,
                                    onTap: _onChapterSelect,
                                  ),
                                ),
                              );
                            },
                          ),
                        )
                      ],
                    )
                  : Center(
                      child: NoItemFound(msg: 'No subject found'),
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
    _subject?.close();
    super.dispose();
  }

  Stream<List<MySubject>> _getStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
      final list = snapshot.docs
          .map((e) => Category.fromJson(e.data()).copyWith(id: e.id))
          .toList(growable: false);
      return sink.add(
        list.firstWhere((element) => element.id == widget.category.id).subjects,
      );
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
        builder: (_) => RecordLessonPage(
            /*category: category,
          subject: subject,
          unit: unit,
          chapter: chapter,*/
            ),
      ),
    );
  }
}
