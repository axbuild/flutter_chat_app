import 'package:chatapp/views/signup.dart';
import 'package:flutter/material.dart';

import 'views/signin.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Chat App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Color(0xFF2e3a4d),
        scaffoldBackgroundColor: Colors.deepOrange,
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: SingUp(),
    );
  }
}
