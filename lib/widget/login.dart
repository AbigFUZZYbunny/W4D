import 'package:flutter/material.dart';
import 'package:whats4dinner/utils/responsive.dart';

class GoogleSignInButton extends StatelessWidget {
  GoogleSignInButton({this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: Responsiveness.setWidth(context, 300.0),
      height: Responsiveness.setHeight(context, 40.0),
      onPressed: this.onPressed,
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "res/img/branding/google_icon.png",
            height: Responsiveness.setHeight(context, 24.0),
            width: Responsiveness.setWidth(context, 24.0),
          ),
          SizedBox(width: Responsiveness.setWidth(context, 24.0)),
          Opacity(
            opacity: 0.54,
            child: Text(
              "Sign in with Google",
              style: TextStyle(
                fontFamily: 'Roboto',
                color: Colors.black,
                fontSize: Responsiveness.setHeight(context, 18.0),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class FacebookSignInButton extends StatelessWidget {
  FacebookSignInButton({this.onPressed});

  final Function onPressed;

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      minWidth: Responsiveness.setWidth(context, 300.0),
      height: Responsiveness.setHeight(context, 40.0),
      onPressed: this.onPressed,
      color: new Color.fromARGB(255, 60, 90, 153),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          Image.asset(
            "res/img/branding/facebook_icon.png",
            height: Responsiveness.setHeight(context, 24.0),
            width: Responsiveness.setWidth(context, 24.0),
          ),
          SizedBox(width: Responsiveness.setWidth(context, 24.0)),
          Text(
            "Continue with Facebook",
            style: TextStyle(
              fontFamily: 'Roboto',
              color: Colors.white,
              fontSize: Responsiveness.setHeight(context, 18.0),
            ),
          ),
        ],
      ),
    );
  }
}