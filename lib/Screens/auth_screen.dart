
import 'package:flutter/material.dart';
import 'package:komunitasku/app_state_container.dart';

class AuthScreen extends StatefulWidget {
  static String tag = 'login-page';
  @override
  _AuthScreenState createState() => new _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  @override
  Widget build(BuildContext context) {
    final container = AppStateContainer.of(context);
    final logo = Hero(
      tag: 'hero',
      child: CircleAvatar(
        backgroundColor: Colors.transparent,
        radius: 48.0,
        child: Image.asset('assets/hacker.png'),
      ),
    );

    // final email = TextFormField(
    //   keyboardType: TextInputType.emailAddress,
    //   autofocus: false,
    //   initialValue: 'alucard@gmail.com',
    //   decoration: InputDecoration(
    //     hintText: 'Email',
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    //   ),
    // );

    // final password = TextFormField(
    //   autofocus: false,
    //   initialValue: 'some password',
    //   obscureText: true,
    //   decoration: InputDecoration(
    //     hintText: 'Password',
    //     contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
    //     border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
    //   ),
    // );

    final loginButton = Padding(
      padding: EdgeInsets.symmetric(vertical: 16.0),
      child: Material(
        borderRadius: BorderRadius.circular(30.0),
        shadowColor: Colors.lightBlueAccent.shade100,
        elevation: 5.0,
        child: MaterialButton(
          minWidth: 200.0,
          height: 42.0,
          onPressed: () => container.logIntoFirebase(),
          color: Colors.pink[500],
          child: Text('Sign in With Google', style: TextStyle(color: Colors.white)),
        ),
      ),
    );

    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: EdgeInsets.only(left: 24.0, right: 24.0),
          children: <Widget>[
            logo,
            SizedBox(height: 48.0),

            loginButton,
            forgotLabel
          ],
        ),
      ),
    );
  }
}