import 'package:flutter/material.dart';

import 'category_page.dart';

class NestedCourseCreation extends StatefulWidget {
  @override
  _NestedCourseCreationState createState() => _NestedCourseCreationState();
}

class _NestedCourseCreationState extends State<NestedCourseCreation> {
  late Widget initialPage;
  final key = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    initialPage = CategoryPage(
      createCourse: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => !await key.currentState!.maybePop(),
      child: Navigator(
        key: key,
        onGenerateInitialRoutes: (state, string) => [
          MaterialPageRoute(builder: (_) => initialPage),
        ],
      ),
    );
  }
}
