import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/record_lesson/models/my_event.dart';
import 'package:flutter_record_lesson/utils/log_utils.dart';
import 'package:flutter_record_lesson/utils/toast_utils.dart';

class PublishLessonPage extends StatefulWidget {
  const PublishLessonPage({
    required this.lesson,
    Key? key,
  }) : super(key: key);
  final Lesson lesson;

  @override
  _PublishLessonPageState createState() => _PublishLessonPageState();
}

class _PublishLessonPageState extends BaseState<PublishLessonPage> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Publish Lesson'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              color: Colors.black12,
              height: 200,
              alignment: Alignment.center,
              child: Text("TBD: Add Video Preview"),
            ),
            ListTile(
              title: Text(widget.lesson.name),
              subtitle: Text(widget.lesson.description),
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            ),
            SectionDivider(),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              title: Text("Ready To Publish?"),
              subtitle: Text(
                "Or you can do it later in future."
                "\n\n"
                "Don't worry your lesson will be saved to your local storage.",
              ),
              isThreeLine: true,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (_isLoading)
                  CircularLoading()
                else
                  RaisedButton(
                    onPressed: () {
                      _onPublishBtnTap();
                    },
                    child: Text('Publish Lesson'),
                  ),
              ],
            ),
            SizedBox(
              height: 20,
            ),
            SectionDivider(),
            ListTile(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 16, horizontal: 16),
              title: Text(
                "Please Note",
                style: TextStyle(fontSize: 14),
              ),
              subtitle: Text(
                "\n1. Lesson should not contain any spam material."
                "\n2. Should follow guidelines."
                "\n\nIf found any violation, "
                "your lesson can be removed from publication in future.",
              ),
              isThreeLine: true,
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _onPublishBtnTap() async {
    try {
      setState(() {
        _isLoading = true;
      });

      // Upload images
      final imageUrls = <String>[];
      final _imageList = widget.lesson.rawImagePaths!
          .map((e) => File(e))
          .toList(growable: false);
      for (var i = 0; i < _imageList.length; i++) {
        final storageReference = FirebaseStorage.instance
            .ref()
            .child('lessons/${widget.lesson.id}/$i.jpg');
        await storageReference.putFile(_imageList.elementAt(i),
            SettableMetadata(contentType: 'image/jpeg'));
        final imageUrl = await storageReference.getDownloadURL();
        imageUrls.add(imageUrl);
      }

      // Upload audio
      final audioFile = File(widget.lesson.audioPath!);
      final storageReference1 = FirebaseStorage.instance
          .ref()
          .child('lessons/${widget.lesson.id}/audio.aac');
      await storageReference1.putFile(
        audioFile,
        SettableMetadata(
          contentType: 'audio/aac',
        ),
      );

      final audioUrl = await storageReference1.getDownloadURL();

      // Upload events
      final jsonString = jsonEncode(widget.lesson.toJson());
      final storageReference = FirebaseStorage.instance
          .ref('lessons/${widget.lesson.id}/events.json');
      await storageReference.putData(
        utf8.encode(jsonString) as Uint8List,
        SettableMetadata(
          contentType: 'application/json',
        ),
      );

      final eventsUrl = await storageReference.getDownloadURL();

      final lessonRef = FirebaseFirestore.instance.collection('lessons').doc(
            widget.lesson.id,
          );

      await lessonRef.set(
        {
          ...widget.lesson
              .copyWith(
                images: imageUrls,
                audioUrl: audioUrl,
                eventsUrl: eventsUrl,
              )
              .copyWith(
                events: null,
                rawImagePaths: null,
                audioPath: null,
              )
              .toJson(),
        },
        SetOptions(merge: true),
      );
      Navigator.of(context).popUntil(
        (route) => route.isFirst,
      );
      ToastUtils.show("Lesson published successfully!");
    } catch (e, s) {
      logger.e(e, s);
      showSnackBar('Something went wrong! Please try again.');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
