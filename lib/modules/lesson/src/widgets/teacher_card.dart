import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/core/widgets/BorderContainer.dart';

class TeacherCard extends StatelessWidget {
  final Course lesson;

  TeacherCard(this.lesson);

  @override
  Widget build(BuildContext context) {
    return BorderContainer(
      child: Container(
        padding: EdgeInsets.all(12),
        width: MediaQuery.of(context).size.width / 2.7,
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
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          fit: BoxFit.cover,
                          image: CachedNetworkImageProvider(
                            'https://firebasestorage.googleapis.com/v0/b/lesson-edd4d.appspot.com/o/extras%2FIMG_20180413_153337_709%20(1).jpg?alt=media&token=4fa13127-edc9-4bee-9ae7-1b7c716dbd1d',
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 4,
              ),
              Text(
                '22 Courses',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontSize: 12,
                    ),
                textAlign: TextAlign.center,
              ),
              SizedBox(
                height: 6,
              ),
              Text(
                'Ayush P Gupta',
                style: Theme.of(context).textTheme.bodyText1.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
