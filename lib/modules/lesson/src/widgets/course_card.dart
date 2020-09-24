import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';

class CourseCard extends StatelessWidget {
  final Course lesson;

  CourseCard(this.lesson);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      child: Container(
        width: MediaQuery.of(context).size.width / 1.6,
        child: GestureDetector(
          onTap: () {
            /*Navigator.of(context).push(
              MaterialPageRoute(
                builder: (_) => PlayLessonPage(
                  lessonId: lesson.id,
                ),
              ),
            );*/
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: CachedNetworkImage(
                  imageUrl: lesson.cover,
                  fit: BoxFit.cover,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  lesson.title,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
