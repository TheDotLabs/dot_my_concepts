import 'package:fa_flutter_core/fa_flutter_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/models/category.dart';
import 'package:flutter_record_lesson/modules/common/src/bloc/record_lesson_bloc.dart';
import 'package:flutter_record_lesson/utils/toast_utils.dart';
import 'package:progress_dialog/progress_dialog.dart';

class CreateCoursePage extends StatefulWidget {
  @override
  _CreateCoursePageState createState() => _CreateCoursePageState();

  const CreateCoursePage({
    this.category,
    this.subject,
    this.unit,
    this.chapter,
  });

  final MyCategory? category;
  final MySubject? subject;
  final MyUnit? unit;
  final MyChapter? chapter;
}

class _CreateCoursePageState extends State<CreateCoursePage> {
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Course'),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                vertical: 8.0,
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
              padding: const EdgeInsets.symmetric(vertical: 8.0),
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
                          ? () async {
                              final progressDialog =
                                  ProgressDialog(context, isDismissible: false)
                                    ..style(message: 'Please Wait !');

                              await progressDialog.show();
                              final result = await injector<RecordLessonBloc>()
                                  .createNewCourse(
                                name: name.text,
                                description: description.text,
                                category: widget.category!,
                                subject: widget.subject!,
                                unit: widget.unit!,
                                chapter: widget.chapter!,
                              );
                              await Future.delayed(Duration(seconds: 2));
                              await Future.wait([
                                progressDialog.hide(),
                              ]);
                              result.when(
                                success: (course) {
                                  Navigator.of(context, rootNavigator: true)
                                      .pop();
                                },
                                failure: (reason) {
                                  ToastUtils.show(reason);
                                },
                              );

                              /*Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (_) => SelectImagePage(),
                                ),
                              );*/
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
