import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/chapter_page.dart';
import 'package:rxdart/rxdart.dart';

class SubjectPage extends StatefulWidget {
  final String categoryId;

  SubjectPage({this.categoryId});

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
        title: Text('Select Unit'),
      ),
      body: StreamBuilder<List<MySubject>>(
        stream: _getStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            final list = snapshot.data;
            return Container(
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 10,
                ),
                children: [
                  ...list.map(
                    (subject) => Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            subject.title.toUpperCase(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ),
                        ...subject.units.map(
                          (e) => Container(
                            margin: EdgeInsets.symmetric(
                              vertical: 8,
                            ),
                            child: BorderContainer(
                              child: ListTile(
                                title: Text(e.title),
                                trailing: Icon(Icons.keyboard_arrow_right),
                                subtitle: e.description != null
                                    ? Text(e.description)
                                    : null,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ChapterPage(
                                        unit: e,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
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
        list.firstWhere((element) => element.id == widget.categoryId).subjects,
      );
    }));
  }
}
