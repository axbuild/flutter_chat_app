import 'dart:async';
import 'package:chatapp/business_logic/utils/authenticate.dart';
import 'package:chatapp/business_logic/view_models/main_screen_viewmodel.dart';
import 'package:chatapp/services/log/logger.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:flutter/material.dart';

void main() {
  setupServiceLocator();
  runZoned(() async {
    runApp(App());
  }, onError: serviceLocator<Logger>().reportError);
}

class App extends StatefulWidget {

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {

  MainScreenViewModel model = serviceLocator<MainScreenViewModel>();

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: model.title,
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff004d40),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: model.userIsLoggedIn ? ChatRoom() : Authenticate(),
    );
  }
}

