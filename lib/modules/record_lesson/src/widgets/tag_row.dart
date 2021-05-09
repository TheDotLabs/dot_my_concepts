import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/src/widgets/box_header.dart';

class TagsRow extends StatelessWidget {
  TagsRow(this.myCourse);

  final MyCourse myCourse;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('categories')
          .doc('${myCourse.categoryId}')
          .get(
            GetOptions(
              source: Source.serverAndCache,
            ),
          ),
      builder: (context, snapshot) {
        if (snapshot.hasData && snapshot.data != null) {
          final category = MyCategory.fromJson(snapshot.data!.data() as Map<String, dynamic>);
          return Wrap(
            runSpacing: 8,
            spacing: 8,
            children: [
              BoxHeader(
                category.title,
                margin: EdgeInsets.zero,
                fontSize: 10,
              ),
              BoxHeader(
                category.subjects!
                    .firstWhere((subject) => subject.id == myCourse.subjectId)
                    .title,
                margin: EdgeInsets.zero,
                fontSize: 10,
              ),
              BoxHeader(
                category.subjects!
                    .firstWhere((subject) => subject.id == myCourse.subjectId)
                    .units!
                    .firstWhere((unit) => unit.id == myCourse.unitId)
                    .title,
                margin: EdgeInsets.zero,
                fontSize: 10,
              ),
              BoxHeader(
                category.subjects!
                    .firstWhere((subject) => subject.id == myCourse.subjectId)
                    .units!
                    .firstWhere((unit) => unit.id == myCourse.unitId)
                    .chapters!
                    .firstWhere((chapter) => chapter.id == myCourse.chapterId)
                    .title,
                margin: EdgeInsets.zero,
                fontSize: 10,
              ),
            ],
          );
        } else
          return SizedBox(
            height: 0,
          );
      },
    );
  }
}
