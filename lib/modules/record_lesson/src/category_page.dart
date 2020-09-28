import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/subject_page.dart';

class CategoryPage extends StatefulWidget {
  @override
  _CategoryPageState createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Category'),
      ),
      body: StreamBuilder<List<Category>>(
          stream: _getStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final list = snapshot.data;
              return Container(
                child: ListView(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  children: [
                    ...list.map(
                      (e) => ListTile(
                        dense: true,
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        leading: CachedNetworkImage(
                          imageUrl: e.image,
                          height: 40,
                          width: 40,
                        ),
                        trailing: Icon(Icons.keyboard_arrow_right),
                        title: Text(e.title),
                        subtitle:
                            e.description != null ? Text(e.description) : null,
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (_) => SubjectPage(
                                category: e,
                              ),
                            ),
                          );
                        },
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
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<Category>> _getStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
      final list = snapshot.docs
          .map((e) => Category.fromJson(e.data()).copyWith(id: e.id))
          .toList(growable: false);
      return sink.add(list);
    }));
  }
}
