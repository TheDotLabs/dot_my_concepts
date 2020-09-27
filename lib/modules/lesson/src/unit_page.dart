import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/widgets/no_item_found.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/view_courses_page.dart';
import 'package:rxdart/rxdart.dart';

class UnitPage extends StatefulWidget {
  final MySubject subject;

  UnitPage({@required this.subject});

  @override
  _UnitPageState createState() => _UnitPageState();
}

class _UnitPageState extends State<UnitPage> {
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
        child: (widget.subject.units != null && widget.subject.units.isNotEmpty)
            ? ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 4,
                ),
                children: [
                  ..._getList().map(
                    (unit) => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(8.0),
                          padding: const EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                            color: Colors.blueGrey[50],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: Text(
                            unit.title.toUpperCase(),
                            style: Theme.of(context).textTheme.overline,
                          ),
                        ),
                        if (unit.chapters != null && unit.chapters.isNotEmpty)
                          ...unit.chapters.map(
                            (e) => Container(
                              child: ListTile(
                                dense: true,
                                title: Text(e.title),
                                subtitle: e.description != null
                                    ? Text(e.description)
                                    : null,
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => ViewCoursesPage(
                                        chapter: e,
                                      ),
                                    ),
                                  );
                                },
                                trailing: Icon(Icons.keyboard_arrow_right),
                              ),
                            ),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: NoItemFound(
                              msg: 'No chapter found',
                            ),
                          )
                      ],
                    ),
                  )
                ],
              )
            : Center(
                child: NoItemFound(
                  msg: 'No data found',
                ),
              ),
      ),
    );
  }

  @override
  void dispose() {
    _subject?.close();
    super.dispose();
  }

  List<MyUnit> _getList() {
    final list = List<MyUnit>.from(widget.subject.units);

    list.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    return list;
  }
}
