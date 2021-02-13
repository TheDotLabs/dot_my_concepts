import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_record_lesson/app/bloc/base/app_bloc.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/circular_loading.dart';
import 'package:flutter_record_lesson/modules/lesson/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/select_category_page.dart';
import 'package:flutter_record_lesson/modules/start_teaching/src/teaching_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _pages = <Widget>[
    FeedPage(),
    TeachingPage(),
    ProfileScreen(),
  ];
  final _pageController = PageController(keepPage: true);

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: StreamBuilder<List<MyCategory>>(
            stream: _getStream(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data != null) {
                final list = snapshot.data;
                final selectedCategory =
                    context.watch<AppBloc>().selectedCategory ?? list[0].id;
                final category = list.firstWhere(
                  (element) => element.id == selectedCategory,
                );
                return InkWell(
                  onTap: _onCategoryTap,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8.0,
                      horizontal: 4,
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          category.title,
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 4.0),
                          child: Icon(Icons.keyboard_arrow_down_rounded),
                        ),
                      ],
                    ),
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(snapshot.error?.toString()),
                );
              } else {
                return Center(
                  child: CircularLoading(),
                );
              }
            }),
        centerTitle: true,
      ),
      /*drawer: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
      ),*/
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (val) {
          setState(() {
            _currentIndex = val;
            _pageController.jumpToPage(val);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.folder),
            label: "Feed",
          ),
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.camrecorder),
            label: "Teach",
          ),
          BottomNavigationBarItem(
            icon: Icon(SimpleLineIcons.user),
            label: "Profile",
          ),
        ],
      ),
    );
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

  void _onCategoryTap() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => SelectCategoryPage(),
      ),
    );
  }
}
