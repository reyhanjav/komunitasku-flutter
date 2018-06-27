import 'package:flutter/material.dart';
//import 'package:komunitasku/Screens/Login/index.dart';
import 'package:komunitasku/app.dart';
import 'package:komunitasku/Screens/auth_screen.dart';


class AppRootWidget extends StatefulWidget {
  @override
  AppRootWidgetState createState() => new AppRootWidgetState();
}

class AppRootWidgetState extends State<AppRootWidget> {
  ThemeData get _themeData => new ThemeData(
        primarySwatch: Colors.pink,
      );

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Komunitasku',
      debugShowCheckedModeBanner: false,
      theme: _themeData,
      routes: {
        '/': (BuildContext context) => new AppScreen(),
        '/auth': (BuildContext context) => new AuthScreen(),
      },
    );
  }
}