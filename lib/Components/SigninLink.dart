import 'package:flutter/material.dart';

class SigninLink extends StatelessWidget {
  SigninLink();
  @override
  Widget build(BuildContext context) {
    return (new FlatButton(
      padding: const EdgeInsets.only(
        top: 120.0,
      ),
      onPressed: () =>
        Navigator.pushReplacementNamed(context, "/login"),
      child: new Text(
        "Already have account? Sign In",
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        softWrap: true,
        style: new TextStyle(
            fontWeight: FontWeight.w300,
            letterSpacing: 0.5,
            color: Colors.white,
            fontSize: 12.0),
      ),
    ));
  }
}

