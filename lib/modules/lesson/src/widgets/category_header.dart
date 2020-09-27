import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';

class CategoryHeader extends StatefulWidget {
  CategoryHeader(this.lesson);

  final Lesson lesson;

  @override
  _CategoryHeaderState createState() => _CategoryHeaderState();
}

class _CategoryHeaderState extends State<CategoryHeader> {
  String _category;

  String _subject;

  String _unit;

  String _chapter;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    init();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: (_unit != null)
          ? Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 12,
              ),
              child: Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(
                      vertical: 4,
                      horizontal: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      borderRadius: BorderRadius.circular(2),
                    ),
                    child: Text(
                      '$_chapter'.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 10,
                            color: Colors.white,
                          ),
                    ),
                  ),
                  Spacer(),
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.grey[200],
                        borderRadius: BorderRadius.circular(2),
                        border: Border.all(
                            color: Colors.blueGrey[100], width: 0.5)),
                    padding: EdgeInsets.symmetric(vertical: 4, horizontal: 6),
                    child: Text(
                      '$_unit'.toUpperCase(),
                      style: Theme.of(context).textTheme.bodyText1.copyWith(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context)
                                .textTheme
                                .bodyText1
                                .color
                                .withOpacity(0.9),
                          ),
                    ),
                  ),
                ],
              ),
            )
          : Container(),
    );
  }

  Future<void> init() async {
    try {
      final categoryDoc = await FirebaseFirestore.instance
          .collection('categories')
          .doc('${widget.lesson.category}')
          .get();

      setState(() {
        _category = categoryDoc.data()['title'];
        _subject = (categoryDoc.data()['subjects'] as List).firstWhere(
            (element) => element['id'] == widget.lesson.subject)['title'];
        _unit = (categoryDoc.data()['subjects'] as List)
            .firstWhere(
                (element) => element['id'] == widget.lesson.subject)['units']
            .firstWhere(
                (element) => element['id'] == widget.lesson.unit)['title'];
        _chapter = (categoryDoc.data()['subjects'] as List)
            .firstWhere(
                (element) => element['id'] == widget.lesson.subject)['units']
            .firstWhere(
                (element) => element['id'] == widget.lesson.unit)['chapters']
            .firstWhere(
                (element) => element['id'] == widget.lesson.chapter)['title'];
      });
    } catch (e, s) {}
  }
}
