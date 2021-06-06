import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/app/bloc/base/app_bloc.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/home/index.dart';

import 'common/src/widgets/circular_loading.dart';

class SelectCategoryPage extends StatefulWidget {
  const SelectCategoryPage({
    this.showHome = false,
    this.title = 'Select Category',
  });

  final bool showHome;
  final String title;

  @override
  _SelectCategoryPageState createState() => _SelectCategoryPageState();
}

class _SelectCategoryPageState extends State<SelectCategoryPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder<List<MyCategory>>(
          stream: _getStream(),
          builder: (context, snapshot) {
            if (snapshot.hasData && snapshot.data != null) {
              final list = snapshot.data!;
              return ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 8,
                ),
                children: [
                  ...list.map(
                    (e) => ListTile(
                      dense: true,
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 8,
                      ),
                      leading: CachedNetworkImage(
                        imageUrl: e.image!,
                        height: 40,
                        width: 40,
                      ),
                      trailing: Icon(Icons.keyboard_arrow_right),
                      title: Text(e.title!),
                      subtitle:
                          e.description != null ? Text(e.description!) : null,
                      onTap: () => _onCategorySelect(e),
                    ),
                  )
                ],
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error as String),
              );
            } else {
              return Center(
                child: CircularLoading(),
              );
            }
          }),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  Stream<List<MyCategory>> _getStream() {
    return FirebaseFirestore.instance
        .collection('categories')
        .snapshots()
        .transform(StreamTransformer.fromHandlers(handleData: (snapshot, sink) {
      final list = snapshot.docs
          .map((e) => MyCategory.fromJson(e.data()).copyWith(id: e.id))
          .toList(growable: false);
      return sink.add(list);
    }));
  }

  void _onCategorySelect(MyCategory e) {
    locator<AppBloc>().onCategorySelection(e);
    if (widget.showHome) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
        (_) => false,
      );
    } else {
      Navigator.of(context).pop();
    }
  }
}
