import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/core/models/course.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/src/bloc/record_lesson_bloc.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/select_images_page.dart';

class CreateLessonPage extends StatefulWidget {
  @override
  _CreateLessonPageState createState() => _CreateLessonPageState();

  const CreateLessonPage({this.course});

  final MyCourse? course;
}

class _CreateLessonPageState extends State<CreateLessonPage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Lesson'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ListTile(
              title: Text(widget.course!.title ?? "--"),
              subtitle: Text(
                widget.course!.subtitle ?? "--",
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 0, vertical: 4),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 4.0,
              ),
              child: Text(
                'NAME',
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            TextField(
              controller: _nameController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 0,
                  horizontal: 2,
                ),
              ),
              maxLength: 100,
              maxLines: 2,
              minLines: 1,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 16,
                  ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 4.0),
              child: Text(
                'Description'.toUpperCase(),
                style: Theme.of(context).textTheme.overline,
              ),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 2,
                ),
              ),
              maxLength: 200,
              minLines: 2,
              maxLines: 5,
              style: Theme.of(context).textTheme.subtitle2!.copyWith(
                    fontSize: 16,
                  ),
            ),
            SizedBox(
              height: 16,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ValueListenableBuilder2<TextEditingValue, TextEditingValue>(
                    _nameController, _descriptionController,
                    builder: (context, name, description, child) {
                  return Theme(
                    data: Theme.of(context).copyWith(
                      buttonTheme: ButtonThemeData(
                        height: 48,
                        textTheme: ButtonTextTheme.primary,
                      ),
                    ),
                    child: RaisedButton(
                      onPressed: checkIfNotEmpty(name.text) &&
                              checkIfNotEmpty(description.text)
                          ? () {
                              injector<RecordLessonBloc>().createNewLesson(
                                name: name.text,
                                description: description.text,
                                course: widget.course!,
                              );
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SelectImagePage(),
                                ),
                              );
                            }
                          : null,
                      child: Text('Proceed'),
                    ),
                  );
                }),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ValueListenableBuilder2<A, B> extends StatelessWidget {
  ValueListenableBuilder2(
    this.first,
    this.second, {
    Key? key,
    this.builder,
    this.child,
  }) : super(key: key);

  final ValueListenable<A> first;
  final ValueListenable<B> second;
  final Widget? child;
  final Widget Function(BuildContext context, A a, B b, Widget? child)? builder;

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<A>(
      valueListenable: first,
      builder: (_, a, __) {
        return ValueListenableBuilder<B>(
          valueListenable: second,
          builder: (context, b, __) {
            return builder!(context, a, b, child);
          },
        );
      },
    );
  }
}
