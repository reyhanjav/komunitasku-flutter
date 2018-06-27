import 'dart:async';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:komunitasku/Screens/auth_screen.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => new _ProfileState();
}

class _ProfileState extends State<Profile> {
  //final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = new GoogleSignIn();




  Future<Null> signOutWithGoogle() async {
  // Sign out with firebase
  await _auth.signOut();
  // Sign out with google
  await _googleSignIn.signOut();
}

  @override
  Widget build(BuildContext context) {

      return new Container(
      child: new Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          new RaisedButton(
            onPressed: () async {
                await signOutWithGoogle();
                Navigator.of(context).pushReplacementNamed('/auth');
              },
            color: Colors.white,
            child: new Container(
              width: 230.0,
              height: 50.0,
              alignment: Alignment.center,
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  new Padding(
                    padding: const EdgeInsets.only(right: 20.0),
                    child: new Image.network(
                      'http://diylogodesigns.com/blog/wp-content/uploads/2016/04/google-logo-icon-PNG-Transparent-Background.png',
                      width: 30.0,
                    ),
                  ),
                  new Text(
                    'Sign out With Google',
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontSize: 16.0,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}