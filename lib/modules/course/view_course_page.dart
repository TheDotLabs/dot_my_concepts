import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/lesson/src/widgets/lesson_card.dart';
import 'package:flutter_record_lesson/modules/profile/src/models/my_user.dart';
import 'package:flutter_record_lesson/modules/rating/rating_page.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';

class ViewCoursePage extends StatefulWidget {
  const ViewCoursePage({
    required this.course,
    Key? key,
    this.user,
  }) : super(key: key);

  final MyCourse course;
  final MyUser? user;

  @override
  _ViewCoursePageState createState() => _ViewCoursePageState();
}

class _ViewCoursePageState extends State<ViewCoursePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Course Details'),
      ),
      body: FutureBuilder<List<Lesson>>(
        future: _getFuture(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data != null) {
            return snapshot.data!.isEmpty
                ? Center(
                    child: Text('No Data Found'),
                  )
                : ListView(
                    children: [
                      SectionDivider(),
                      SectionHeader('COURSE DETAILS'),
                      ListTile(
                        title: Text(widget.course.title ?? "--"),
                        subtitle: Text(widget.course.subtitle ?? "--"),
                        trailing: widget.course.rating != null
                            ? InkWell(
                                onTap: widget.course.rating != null
                                    ? () {
                                        Navigator.of(context).push(
                                          MaterialPageRoute(
                                            builder: (_) => RatingPage(
                                              ratings: widget.course.rating!,
                                              userId: widget.course.userId,
                                            ),
                                          ),
                                        );
                                      }
                                    : null,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '⭐ ${widget.course.rating!.fold<double>(0, (previousValue, element) => element.number + previousValue).toStringAsFixed(1)}',
                                        style: TextStyle(
                                          color: Colors.orangeAccent,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      )
                                    ],
                                  ),
                                ),
                              )
                            : null,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 16,
                              backgroundImage: CachedNetworkImageProvider(
                                widget.user?.avatar ?? "-",
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Text(widget.user?.name ?? "--"),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      SectionDivider(),
                      SectionHeader('ALL LESSONS (${snapshot.data!.length})'),
                      ...snapshot.data!.map(
                        (e) => Container(height: 220, child: LessonCard(e)),
                      ),
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
        },
      ),
    );
  }

  Future<List<Lesson>> _getFuture() async {
    final doc = await FirebaseFirestore.instance
        .collection('lessons')
        .where('course', isEqualTo: widget.course.id)
        .get();
    return doc.docs
        .map((e) => Lesson.fromJson(e.data()).copyWith(id: e.id))
        .toList(growable: false);
  }
}
