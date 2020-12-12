import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/data/login_repository.dart';
import 'package:flutter_record_lesson/data/repo/google_login_repository.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/home/index.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
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
            Spacer(),
            Text(
              'DotMyConcepts',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'Your Teaching Made Easy',
              style: Theme.of(context).textTheme.bodyText2.copyWith(
                    fontSize: 12,
                  ),
              textAlign: TextAlign.center,
            ),
            Spacer(),
            SignInButton(
              Buttons.Google,
              onPressed: () => _login(LoginProvider.google),
            ),
            Spacer(),
            Text(
              'By signing up you agree to\n'
              'Terms & Conditions',
              style: TextStyle(
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(
              height: 16,
            ),
            Text(
              '©️${DateTime.now().year}. All Rights Reserved',
              style: TextStyle(
                fontSize: 12,
              ),
            ),
            SizedBox(
              height: 16,
            ),
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
