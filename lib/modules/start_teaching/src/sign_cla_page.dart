import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/app/bloc/base/app_bloc.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/record_lesson/src/category_page.dart';

class SignClaPage extends StatefulWidget {
  @override
  _SignClaPageState createState() => _SignClaPageState();
}

class _SignClaPageState extends State<SignClaPage> {
  final _qaList = <QA>[
    QA(title: "I will respect the integrity of being a teacher"),
    QA(title: "I will not spam the platform with irrelevant stuff"),
    QA(title: "I will refrain using copyright content"),
    QA(title: "I am responsible for the content i create on this platform"),
    QA(title: "I am will refrain from spamming my personal portfolio links"),
  ];

  get _allQAAccepted =>
      _qaList.where((element) => element.value!).length == _qaList.length;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Agreement'),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(
          horizontal: 4,
          vertical: 8,
        ),
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "Please check all the guidelines",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          ..._qaList.map(
            (e) => CheckboxListTile(
              title: Text(
                e.title!,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                ),
              ),
              value: e.value,
              onChanged: (val) {
                setState(() {
                  e.value = val;
                });
              },
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              "${_qaList.where((element) => element.value!).length}/${_qaList.length} accepted",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
                color: _allQAAccepted ? Colors.green : null,
              ),
            ),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Theme(
                data: Theme.of(context).copyWith(
                  buttonTheme: ButtonThemeData(
                    height: 48,
                    textTheme: ButtonTextTheme.primary,
                  ),
                ),
                child: RaisedButton(
                  onPressed: _allQAAccepted
                      ? () {
                          locator<AppBloc>().saveUserSignedCla();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                              builder: (_) => CategoryPage(),
                            ),
                          );
                        }
                      : null,
                  child: Text('Proceed'),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
  }
}

class QA {
  final String? title;
  bool? value;

  QA({
    this.title,
    this.value = false,
  });
}
