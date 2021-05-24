import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/widgets/no_item_found.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/box_header.dart';
import 'package:rxdart/rxdart.dart';

typedef ChapterSelectCallback = void Function({
  MyCategory? category,
  MySubject? subject,
  MyUnit? unit,
  MyChapter? chapter,
});

class SelectUnitPage extends StatefulWidget {
  final MySubject subject;
  final MyCategory? category;
  final ChapterSelectCallback onTap;

  SelectUnitPage({
    required this.subject,
    required this.category,
    required this.onTap,
  });

  @override
  _SelectUnitPageState createState() => _SelectUnitPageState();
}

class _SelectUnitPageState extends State<SelectUnitPage> {
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
        child: (widget.subject.units != null &&
                widget.subject.units!.isNotEmpty)
            ? ListView(
                physics: BouncingScrollPhysics(),
                padding: EdgeInsets.symmetric(
                  horizontal: 4,
                  vertical: 4,
                ),
                children: [
                  ..._getList().map(
                    (unit) => Column(
                      children: [
                        BoxHeader(unit.title!.toUpperCase()),
                        if (unit.chapters != null && unit.chapters!.isNotEmpty)
                          ..._getChapterList(unit.chapters!).map(
                            (chapter) => Container(
                              child: ListTile(
                                dense: true,
                                title: Text(chapter.title!),
                                subtitle: chapter.description != null
                                    ? Text(chapter.description!)
                                    : null,
                                onTap: () {
                                  widget.onTap(
                                    category: widget.category,
                                    subject: widget.subject,
                                    unit: unit,
                                    chapter: chapter,
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
    _subject.close();
    super.dispose();
  }

  List<MyUnit> _getList() {
    final list = List<MyUnit>.from(widget.subject.units!);

    list.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    return list;
  }

  List<MyChapter> _getChapterList(List<MyChapter> rawList) {
    final list = List<MyChapter>.from(rawList);

    list.sort((a, b) => int.parse(a.id).compareTo(int.parse(b.id)));
    return list;
  }
}
