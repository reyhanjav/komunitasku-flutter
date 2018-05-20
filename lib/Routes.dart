import 'package:flutter/material.dart';
import 'package:komunitasku/Screens/Login/index.dart';
import 'package:komunitasku/Screens/drawer/drawer.dart';
import 'package:komunitasku/Screens/Signup/index.dart';

class Routes {
  Routes() {
    runApp(new MaterialApp(
      title: "Komunitasku",
      theme: new ThemeData(
        primarySwatch: Colors.pink,
      ),
      debugShowCheckedModeBanner: false,
      home: new LoginScreen(),
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/login':
            return new MyCustomRoute(
              builder: (_) => new LoginScreen(),
              settings: settings,
            );

          case '/home':
            return new MyCustomRoute(
              builder: (_) => new UserDrawer(),
              settings: settings,
            );

          case '/signup':
            return new MyCustomRoute(
              builder: (_) => new SignupScreen(),
              settings: settings,
            );
        }
      },
    ));
  }
}

class MyCustomRoute<T> extends MaterialPageRoute<T> {
  MyCustomRoute({WidgetBuilder builder, RouteSettings settings})
      : super(builder: builder, settings: settings);

  @override
  Widget buildTransitions(BuildContext context, Animation<double> animation,
      Animation<double> secondaryAnimation, Widget child) {
    if (settings.isInitialRoute) return child;
    return new FadeTransition(opacity: animation, child: child);
  }
}
