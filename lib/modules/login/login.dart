import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/data/login_repository.dart';
import 'package:flutter_record_lesson/data/repo/google_login_repository.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/home/index.dart';
import 'package:progress_dialog/progress_dialog.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends BaseState<LoginScreen> {
  final _emailTextController = TextEditingController();
  final _passwordTextController = TextEditingController();

  Future<void> _login(LoginProvider service) async {
    final progressDialog = ProgressDialog(context, isDismissible: false)
      ..style(message: 'Please Wait !');
    await progressDialog.show();
    switch (service) {
      case LoginProvider.google:
        final result = await injector<GoogleLoginRepository>().login();
        await progressDialog.hide();
        result.when(
          success: (_) {
            _onLoginSuccess();
          },
          error: (error) {
            showSnackBar('Oops! Something went wrong. Error: $error');
          },
        );
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(height: 28),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16),
              child: RaisedButton(
                elevation: 3,
                color: Colors.black,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(30),
                ),
                onPressed: () {
                  _login(LoginProvider.google);
                  /*   Navigator.push(context, MaterialPageRoute(builder: (context) {
                    return IntroScreen();
                  }));*/
                },
                child: Padding(
                  padding: EdgeInsets.all(20),
                  child: Text(
                    'Get started',
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _onLoginSuccess() {
    Navigator.of(context).pushAndRemoveUntil(
      MaterialPageRoute(builder: (_) => HomePage()),
      (route) => false,
    );
    /* Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.HOME,
      (_) => false,
    );*/
  }
}
