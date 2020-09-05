
import 'dart:convert';
import 'dart:io';
import 'dart:math';

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
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/progress_button.dart';


class SignInScreenModelView extends ChangeNotifier {

  DatabaseService  databaseService = serviceLocator<DatabaseService>();
  OptionStorageService  optionStorageService = serviceLocator<OptionStorageService>();

  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();

  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  bool isLoading = false;
  QuerySnapshot snapshotUserInfo;

  User user;

  Future<bool> signIn() async {
    isLoading = true;

    if(formKey.currentState.validate()){

      await databaseService.getUserByEmail(emailTextEditingController.text.trim())
          .then((value) => user = value);

      authenticationServiceDefault.email = emailTextEditingController.text.trim();
      authenticationServiceDefault.password = passwordTextEditingController.text.trim();

      return await authenticationServiceDefault.signIn()
        .then((value){
        if(value != null){
          user.isLogged = true;
          optionStorageService.save('user', user.toMap());
          Local.user = user;
          return true;
        } else {
          return false;
        }
      });
    }
  }

  Future getData() async {
    return await Future.delayed(Duration(seconds: 2));
  }

  Future<bool> signInWithGoogle() async {
    isLoading = true;

    await authenticationServiceGoogle.signIn()
      .then((value){
      if(value != null){
        user.isLogged = true;
        optionStorageService.save('user', user.toMap());
        Local.user = user;
        return true;
      } else {
        return false;
      }
    });
    // .then((value) => finishAuthorize(context, value));

  }



  // void finishAuthorize(BuildContext context, dynamic value){
  //   if(value != null){
  //     user.isLogged = true;
  //     optionStorageService.save('user', user.toMap());
  //
  //     Local.user = user;
  //
  //     Navigator.pushReplacement(context, MaterialPageRoute(
  //         builder: (context) => RoomsScreen()
  //     ));
  //     notifyListeners();
  //   } else {
  //     showPopUpDialog(context, 'User not found!');
  //   }
  // }

  void loadData() async {
     notifyListeners();
  }

}