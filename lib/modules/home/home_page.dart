import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/lesson/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/lesson_record_page.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = <Widget>[
    FeedPage(),
    LessonRecordPage(),
  ];
  final _pageController = PageController(keepPage: true);

  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "JEE Mains and Advance",
        ),
      ),
      drawer: Container(
        width: MediaQuery.of(context).size.width / 1.2,
        color: Colors.white,
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [...pages],
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
            icon: Icon(Icons.list_alt_outlined),
            title: Text("Feed"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            title: Text("Course"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.video_call_outlined),
            title: Text("Record"),
          ),
        ],
      ),
    );
  }
}
