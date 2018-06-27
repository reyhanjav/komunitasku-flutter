import 'package:flutter/material.dart';
import 'package:komunitasku/Routes.dart';
import 'package:komunitasku/app_state_container.dart';
void main() {
  runApp(new AppStateContainer(
    child: new AppRootWidget(),
  ));
}