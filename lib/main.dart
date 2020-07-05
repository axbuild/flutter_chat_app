import 'dart:async';
import 'package:chatapp/core/helper/authenticate.dart';
import 'package:chatapp/core/helper/helperfunctions.dart';
import 'package:chatapp/core/services/log.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:flutter/material.dart';
import 'core/helper/push_notifications.dart';

void main() {
//  runApp(MyApp());
  runZoned(() async {
    runApp(MyApp());
  }, onError: LogProvider.reportError);
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  bool userIsLoggedIn = false;

  @override
  void initState() {
    //TODO
    PushNotificationsManager pushNotificationsManager = PushNotificationsManager();
    pushNotificationsManager.init();

    getLoggedInState();
    super.initState();
  }

  getLoggedInState() async {
    await HelperFunctions.getUserLoggedSharedPreference().then((value){
      print("getLoggedInState:value: ${value}");
      setState(() {
        userIsLoggedIn = value ?? false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xff004d40),
        scaffoldBackgroundColor: Colors.white,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: userIsLoggedIn ? ChatRoom() : Authenticate(),
    );
  }
}

