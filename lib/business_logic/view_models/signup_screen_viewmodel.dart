import 'dart:convert';

import 'package:chatapp/business_logic/models/settings.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/ui/screens/rooms_screen.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class SignUpScreenViewModel extends ChangeNotifier {

  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();
  DatabaseService databaseService = serviceLocator<DatabaseService>();
  OptionStorageService optionStorageService = serviceLocator<OptionStorageService>();

//  User user;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

//  Map<String, String> userInfoMap = {};

  bool signUp(BuildContext context){
//    user = User.empty();
    if(!formKey.currentState.validate()) return false;

      isLoading = true;

      authenticationServiceDefault.email = emailTextEditingController.text.trim();
      authenticationServiceDefault.password = passwordTextEditingController.text.trim();
      authenticationServiceDefault.signUp()
          .then((value) => finishAuthorize(context, value));

      return true;
  }

  void googleSignUp(BuildContext context){
    authenticationServiceGoogle.signUp()
        .then((value) => finishAuthorize(context, value));
  }

  void finishAuthorize(BuildContext context, User user){
    if(user != null) {
      user.name = userNameTextEditingController.text.trim();
      databaseService.uploadUserInfo(user.toMap());

      Local.user = user;
      createEntity();
      user.isLogged = true;
      optionStorageService.save('user', user.toMap());
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => RoomsScreen()
      ));
    } else {
      showPopUpDialog(context, 'User already exist, smth wrong!');
    }
  }

  Future<http.Response> createEntity() {
    return http.post(
      Settings().crm+'crm.contact.add/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, dynamic>{
        'fields':
        {
          "NAME": Local.user.name,
          "SECOND_NAME": Local.user.name,
          "LAST_NAME": Local.user.email,
          "OPENED": "Y",
          "ASSIGNED_BY_ID": 1,
          "TYPE_ID": "CLIENT",
          "SOURCE_ID": "SELF",
          "UF_CRM_1599388563618": Local.user.sid
        }
      }),
    );
  }

  void loadData(){
    notifyListeners();
  }
}