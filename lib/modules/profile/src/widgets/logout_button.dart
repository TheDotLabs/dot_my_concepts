import 'package:flutter/material.dart';
import 'package:flutter_record_lesson/di/injector.dart';
import 'package:flutter_record_lesson/modules/login/index.dart';
import 'package:flutter_record_lesson/modules/profile/index.dart';
import 'package:flutter_record_lesson/utils/toast_utils.dart';

class LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Container(
        height: 48.0,
        child: RaisedButton(
          onPressed: () async {
            _showDialog(context);
          },
          color: Colors.white,
          elevation: 0,
          highlightElevation: 0,
          hoverElevation: 0,
          focusElevation: 0,
          child: Text(
            'Logout',
            style: TextStyle(color: Colors.red, fontWeight: FontWeight.w800),
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(BuildContext context) async {
    await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Logout"),
          content: Text("Are you sure you want to logout?"),
          actions: <Widget>[
            FlatButton(
              child: Text("Cancel"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            FlatButton(
              child: Text("Proceed"),
              onPressed: () async {
                final result = await injector<UserRepository>().logoutUser();
                result.when(
                  success: (_) {
                    Navigator.of(context).pushAndRemoveUntil(
                      MaterialPageRoute(
                        builder: (_) => LoginScreen(),
                      ),
                      (route) => false,
                    );
                  },
                  failure: (err) {
                    ToastUtils.show('Something went wrong! $err');
                  },
                );
              },
            ),
          ],
        );
      },
    );
  }
}
