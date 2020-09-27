import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/category_page.dart';

class LessonRecordPage extends StatefulWidget {
  @override
  _LessonRecordPageState createState() => _LessonRecordPageState();
}

class _LessonRecordPageState extends State<LessonRecordPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                "Start Recording Lesson",
              ),
            ),
            RaisedButton(
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CategoryPage(),
                  ),
                );
              },
              child: Text('Record'.toUpperCase()),
            )
          ],
        ),
      ),
    );
  }
}
