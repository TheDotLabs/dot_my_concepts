import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:lottie/lottie.dart';

import '../select_category_page.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
            'Hi, ${locator<UserRepository>().getLoggedInUser()?.name ?? "-"}'),
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(
              'assets/logo.png',
              height: 62,
            ),
            SizedBox(
              height: 24,
            ),
            Text(
              "Welcome to DotMyConcept",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              "Let's get started",
              style: TextStyle(
                fontSize: 14,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Lottie.asset(
              'assets/lottie/27637-welcome.json',
              height: MediaQuery.of(context).size.height / 2.7,
            ),
            Theme(
              data: Theme.of(context).copyWith(
                buttonTheme: ButtonThemeData(
                  height: 48,
                  textTheme: ButtonTextTheme.primary,
                ),
              ),
              child: RaisedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                        builder: (_) => SelectCategoryPage(
                              showHome: true,
                              title: 'Start by selecting a course',
                            )),
                  );
                },
                child: Text('Start Learning'),
              ),
            ),
            SizedBox(
              height: 24,
            ),
          ],
        ),
      ),
    );
  }
}
