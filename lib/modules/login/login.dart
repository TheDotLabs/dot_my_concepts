import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/data/login_repository.dart';
import 'package:flutter_record_lesson/data/repo/google_login_repository.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/common/index.dart';
import 'package:flutter_record_lesson/modules/home/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/modules/select_category_page.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:lottie/lottie.dart';
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
        final result = await locator<GoogleLoginRepository>().login();
        await progressDialog.hide();
        result.when(
          success: (_) {
            _onLoginSuccess();
          },
          failure: (error) {
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
      body: Stack(
        alignment: Alignment.center,
        children: [
          Opacity(
            opacity: 0.14,
            child: Lottie.asset(
              'assets/lottie/17848-bubbles.json',
            ),
          ),
          Container(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Spacer(),
                Image.asset(
                  'assets/logo.png',
                  height: 70,
                ),
                SizedBox(
                  height: 16,
                ),
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
                  style: Theme.of(context).textTheme.bodyText2!.copyWith(
                        fontSize: 12,
                      ),
                  textAlign: TextAlign.center,
                ),
                Spacer(),
                Text(
                  'Start by signing in with your'
                  '\nGoogle account',
                  style: TextStyle(
                    fontSize: 12,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 16,
                ),
                SignInButton(
                  Buttons.Google,
                  onPressed: () => _login(LoginProvider.google),
                ),
                Spacer(
                  flex: 2,
                ),
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
                  height: 28,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onLoginSuccess() {
    if (locator<UserRepository>().getLoggedInUser()!.selectedCategory != null) {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => HomePage(),
        ),
        (route) => false,
      );
    } else {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(
          builder: (_) => SelectCategoryPage(
            showHome: true,
            title: 'Start by selecting a course',
          ),
        ),
        (route) => false,
      );
    }
    /* Navigator.pushNamedAndRemoveUntil(
      context,
      Routes.HOME,
      (_) => false,
    );*/
  }
}
