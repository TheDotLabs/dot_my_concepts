import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/app/bloc/base/app_bloc.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/category_page.dart';
import 'package:flutter_record_lesson/modules/start_teaching/src/sign_cla_page.dart';
import 'package:lottie/lottie.dart';

class StartTeachingPage extends StatefulWidget {
  @override
  _StartTeachingPageState createState() => _StartTeachingPageState();
}

class _StartTeachingPageState extends State<StartTeachingPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Teach your first lesson",
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
              "It's a lot easier than you think",
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            Lottie.asset(
              'assets/lottie/31878-teacher.json',
              height: MediaQuery.of(context).size.height / 2.5,
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
                  if (locator<AppBloc>().hasUserSignedCla) {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => CategoryPage(),
                      ),
                    );
                  } else {
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (_) => SignClaPage(),
                      ),
                    );
                  }
                },
                child: Text('Start Teaching'),
              ),
            )
          ],
        ),
      ),
    );
  }
}
