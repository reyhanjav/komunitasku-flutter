import 'package:flutter/material.dart';
import 'package:komunitasku/app_state_container.dart';
import 'package:komunitasku/models/app_state.dart';
import 'package:komunitasku/Screens/auth_screen.dart';
import 'package:komunitasku/Screens/drawer/drawer_user.dart';

class AppScreen extends StatefulWidget {
  @override
  AppScreenState createState() => new AppScreenState();
}

class AppScreenState extends State<AppScreen> {
  AppState appState;

  Widget get _pageToDisplay {
    if (appState.isLoading) {
      return _loadingView;
    } else if (!appState.isLoading && appState.user == null) {
      return new AuthScreen();
    } else {
      return new UserDrawer();
    }
  }

  Widget get _loadingView {
    return new Container(
      alignment: Alignment.bottomCenter,
      padding: new EdgeInsets.only(top: 20.0),
      child: new LinearProgressIndicator(),
    );
  }


  @override
  Widget build(BuildContext context) {
    var container = AppStateContainer.of(context);
    appState = container.state;
    Widget body = _pageToDisplay;

    return new Container(
       decoration: new BoxDecoration(
          image: new DecorationImage(
            image: new AssetImage("assets/logo.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      child: body,
      
    );
  }
}
