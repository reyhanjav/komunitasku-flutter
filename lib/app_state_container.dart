import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:komunitasku/models/app_state.dart';
import 'package:komunitasku/models/user.dart';
import 'package:komunitasku/Screens/pilihKomunitas.dart';


final ref = Firestore.instance.collection('komunitas_users');
User currentUserModel;

class AppStateContainer extends StatefulWidget {
  final AppState state;
  final Widget child;

  AppStateContainer({
    @required this.child,
    this.state,
  });

  // This creates a method on the AppState that's just like 'of'
  // On MediaQueries, Theme, etc
  // This is the secret to accessing your AppState all over your app
  static _AppStateContainerState of(BuildContext context) {
    return (context.inheritFromWidgetOfExactType(_InheritedStateContainer)
            as _InheritedStateContainer)
        .data;
  }

  @override
  _AppStateContainerState createState() => new _AppStateContainerState();
}

class _AppStateContainerState extends State<AppStateContainer> {
  AppState state;
  GoogleSignInAccount googleUser;
  final googleSignIn = new GoogleSignIn();

  @override
  void initState() {
    super.initState();
    if (widget.state != null) {
      state = widget.state;
    } else {
      state = new AppState.loading();
      initUser();
    }
  }

  Future initUser() async {
    googleUser = await _ensureLoggedInOnStartUp();
    if (googleUser == null) {
      setState(() {
        state.isLoading = false;
      });
    } else {
      var firebaseUser = await logIntoFirebase();
    }
  }

  logIntoFirebase() async {
    if (googleUser == null) {
      googleUser = await googleSignIn.signIn();
    }
    if (googleUser == null) {
      googleUser = await googleSignIn.signIn().then((_) {
      tryCreateUserRecord(context);
    });
    }
    

    FirebaseUser firebaseUser;
    FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      GoogleSignInAuthentication googleAuth = await googleUser.authentication;
      firebaseUser = await _auth.signInWithGoogle(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );
      print('Logged in: ${firebaseUser.displayName}');
      setState(() {
        state.isLoading = false;
        state.user = firebaseUser;
      });
    } catch (error) {
      print(error);
      return null;
    }
  }

  Future<dynamic> _ensureLoggedInOnStartUp() async {
    GoogleSignInAccount user = googleSignIn.currentUser;
    if (user == null) {
      user = await googleSignIn.signInSilently();
    }
    googleUser = user;
    return user;
  }

  tryCreateUserRecord(BuildContext context) async {
  GoogleSignInAccount user = googleSignIn.currentUser;
  // if (user == null) {
  //   return null;
  // }
  DocumentSnapshot userRecord = await ref.document(user.id).get();
  if (userRecord.data == null) {
    // no user record exists, time to create

    // String userCommunity = await Navigator.push(
    //   context,
    //   // We'll create the SelectionScreen in the next step!
    //   new MaterialPageRoute(
    //       builder: (context) => new Center(
    //             child: new Scaffold(
    //                 appBar: new AppBar(
    //                   leading: new Container(),
    //                   title: new Text('Pilih Komunitas',
    //                       style: new TextStyle(
    //                           color: Colors.black,
    //                           fontWeight: FontWeight.bold)),
    //                   backgroundColor: Colors.white,
    //                 ),
    //                 body: new ListView(
    //                   children: <Widget>[
    //                     new Container(
    //                       child: new CreateAccount(),
    //                     ),
    //                   ],
    //                 )),
    //           )),
    // );

    //if (userCommunity != null || userCommunity.length != 0){
      ref.document(user.id).setData({
        "id": user.id,
        "community":"Agriweb",
        "roles": "Anggota",
        "photoUrl": user.photoUrl,
        "email": user.email,
        "displayName": user.displayName,
        "gender": "",
        "phoneNumber": "",
        "favorites":"",
        "xp": "",
        "level":"1",
        "generation":"",
        "status": "Apprentice",
      });
    //}
  }

  currentUserModel = new User.fromDocument(userRecord);
}


  @override
  Widget build(BuildContext context) {
    return new _InheritedStateContainer(
      data: this,
      child: widget.child,
    );
  }
}

class _InheritedStateContainer extends InheritedWidget {
  final _AppStateContainerState data;

  _InheritedStateContainer({
    Key key,
    @required this.data,
    @required Widget child,
  }) : super(key: key, child: child);

  @override
  bool updateShouldNotify(_InheritedStateContainer old) => true;
}
