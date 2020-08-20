import 'dart:async';
import 'package:chatapp/business_logic/utils/authenticate.dart';
import 'package:chatapp/business_logic/view_models/main_screen_viewmodel.dart';
import 'package:chatapp/services/log/logger.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/screens/rooms_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';


import 'business_logic/utils/helper.dart';
import 'business_logic/utils/local.dart';
import 'business_logic/utils/universal_variables.dart';

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
//      theme: ThemeData(brightness: Brightness.light),
      theme: ThemeData(
        primaryColor: Color(UniversalVariables.primeColor),
        scaffoldBackgroundColor: Colors.white,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
//      home: model.user.isLogged ? RoomsScreen() : Authenticate(),
      home: LoaderOverlay(
        overlayWidget: Center(
          child: SpinKitCubeGrid(
            color: Colors.red,
            size: 50.0,
          ),
        ),
        overlayOpacity: 0.8,
        child: model.user.isLogged ? RoomsScreen() : Authenticate(),
      )
    );
  }
}

