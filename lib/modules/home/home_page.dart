import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/lesson/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/record_lesson.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final pages = <Widget>[LessonViewPage(), RecordLessonPage()];
  final _pageController = PageController(keepPage: true);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("MyLearn"),
      ),
      body: PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [...pages],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _pageController.page.toInt(),
        onTap: (val) {
          setState(() {
            _pageController.jumpToPage(val);
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            title: Text("Lessons"),
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
