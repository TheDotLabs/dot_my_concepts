import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/record_lesson.dart';
import 'package:rxdart/rxdart.dart';

class ChapterPage extends StatefulWidget {
  final MyUnit unit;

  ChapterPage({@required this.unit});

  @override
  _ChapterPageState createState() => _ChapterPageState();
}

class _ChapterPageState extends State<ChapterPage> {
  final _subject = BehaviorSubject<List<MySubject>>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Select Chapter'),
      ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(
            horizontal: 8,
          ),
          children: [
            ...widget.unit.chapters.map(
              (e) => Container(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                ),
                child: BorderContainer(
                  child: ListTile(
                    title: Text(e.title),
                    subtitle:
                        e.description != null ? Text(e.description) : null,
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => RecordLessonPage(),
                        ),
                      );
                    },
                    trailing: Icon(Icons.keyboard_arrow_right),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    _subject?.close();
    super.dispose();
  }
}
