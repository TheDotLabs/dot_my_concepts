import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String label;
  final String assetName;
  final VoidCallback onClick;

  const LoginButton({
    Key key,
    @required this.label,
    @required this.onClick,
    @required this.assetName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
//      decoration: BoxDecoration(boxShadow: [
//        BoxShadow(
//          color: Colors.black12,
//          blurRadius: 64.0,
//          offset: Offset(0.0, 10.0),
//        ),
//      ]),
      child: RaisedButton(
        padding: const EdgeInsets.symmetric(horizontal: 4.0),
        color: Colors.white,
        onPressed: onClick,
        elevation: 1.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(36.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: Row(
            children: <Widget>[
              //if (!kIsWeb) SvgIcon(assetName: assetName),
              SizedBox(width: 24.0),
              Text(
                label,
                style: TextStyle(
                  fontSize: 16.0,
                  color: Colors.black87,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Spacer(),
              Icon(
                Icons.arrow_forward,
                color: Colors.black87,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
