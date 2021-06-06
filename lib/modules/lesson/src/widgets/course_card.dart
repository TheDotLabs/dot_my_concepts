import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';
import 'package:flutter_record_lesson/modules/course/view_course_page.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';

class CourseCard extends StatelessWidget {
  final MyCourse course;

  CourseCard(this.course);

  final colors = [
    0xFF0984e3,
    0xFFe17055,
    0xFF00b894,
    0xFF636e72,
    0xFF2d3436,
  ];

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyUser?>(
        future: _getFuture(course.userId),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) =>
                      ViewCoursePage(course: course, user: snapshot.data),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 4),
              child: BorderContainer(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.35,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(
                        child: CachedNetworkImage(
                          imageUrl: course.cover ?? '-',
                          fit: BoxFit.cover,
                          errorWidget: (_, __, ___) {
                            return Container(
                              color: Color(colors.randomItem()),
                              padding: EdgeInsets.all(4),
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Text(
                                        '${course.title!}',
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        textAlign: TextAlign.center,
                                      ),
                                      Text(
                                        '\n- ${snapshot.data!.name}',
                                        style: TextStyle(
                                            color: Colors.white, fontSize: 10),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 0,
                                    right: 0,
                                    child: Opacity(
                                      opacity: 0.87,
                                      child: Image.asset(
                                        'assets/logo.png',
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 2,
                                    left: 3,
                                    child: CircleAvatar(
                                      radius: 16,
                                      backgroundImage:
                                          CachedNetworkImageProvider(
                                        snapshot.data?.avatar ?? "-",
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      ),
                      Divider(
                        height: 1,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          course.title!,
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Text(
                          '${snapshot.data?.name ?? '---'}',
                          style:
                              Theme.of(context).textTheme.bodyText1!.copyWith(
                                    fontSize: 12,
                                  ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  Future<MyUser?> _getFuture(String userId) async {
    final doc =
        await FirebaseFirestore.instance.collection('users').doc(userId).get();
    return MyUser.fromJson(doc.data() ?? {});
  }
}

extension RandomListItem<T> on List<T> {
  T randomItem() {
    return this[Random().nextInt(length)];
  }
}
