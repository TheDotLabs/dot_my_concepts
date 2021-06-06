import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';
import 'package:flutter_record_lesson/modules/play_lesson/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';

import 'category_header.dart';

class LessonCard extends StatelessWidget {
  final Lesson lesson;

  LessonCard(this.lesson);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<MyUser?>(
        future: _getFuture(lesson.uid),
        builder: (context, snapshot) {
          return GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => PlayLessonPage(
                    lessonId: lesson.id,
                  ),
                ),
              );
            },
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 8),
              child: BorderContainer(
                child: Container(
                  width: MediaQuery.of(context).size.width / 1.35,
                  child: Column(
                    children: [
                      Expanded(
                        child: lesson.images == null
                            ? Container()
                            : Stack(
                                children: [
                                  Positioned.fill(
                                    child: CachedNetworkImage(
                                      imageUrl: lesson.images![0],
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                  CategoryHeader(lesson),
                                  Positioned(
                                    bottom: 4,
                                    right: 4,
                                    child: Opacity(
                                      opacity: 0.87,
                                      child: Image.asset(
                                        'assets/logo.png',
                                        height: 24,
                                      ),
                                    ),
                                  ),
                                  Positioned(
                                    bottom: 4,
                                    left: 6,
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
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              lesson.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.w700,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 2,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: Text(
                              '${snapshot.data?.name ?? '---'}',
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontSize: 12,
                                  ),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      )
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
