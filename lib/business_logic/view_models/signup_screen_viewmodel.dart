import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'file:///C:/Users/29228796/AndroidStudioProjects/flutter_chat_app/lib/services/predicated/auth.dart';
import 'package:chatapp/services/authentication/authentication_service_default.dart';
import 'package:chatapp/services/authentication/authentication_service_google.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreenViewModel extends ChangeNotifier {

  AuthenticationServiceDefault authenticationServiceDefault = serviceLocator<AuthenticationServiceDefault>();
  AuthenticationServiceGoogle authenticationServiceGoogle = serviceLocator<AuthenticationServiceGoogle>();
  DatabaseService databaseService = serviceLocator<DatabaseService>();
  OptionStorageService optionStorageService = serviceLocator<OptionStorageService>();

  User user;
  bool isLoading = false;

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  Map<String, String> userInfoMap = {};

  bool signUp(BuildContext context){
    user = User.empty();
    if(!formKey.currentState.validate()) return false;

      isLoading = true;

      userInfoMap = {
        "name" : userNameTextEditingController.text,
        "email" : emailTextEditingController.text,
        "token" : Constants.token
      };

      user.name = userNameTextEditingController.text;
      user.email = emailTextEditingController.text;
      optionStorageService.save('user', user.toJson());

      authenticationServiceDefault.email = emailTextEditingController.text.trim();
      authenticationServiceDefault.password = passwordTextEditingController.text.trim();
      authenticationServiceDefault.signUp()
          .then((val){
            databaseService.uploadUserInfo(userInfoMap);

            user.isLogged = true;
            optionStorageService.save('user', user.toJson());
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => ChatRoom()
            ));
          });

      return true;
  }

  void googleSignUp(BuildContext context){
    authenticationServiceGoogle.signUp().then((val){
      /*userInfoMap = {
          "name" : val.name,
          "email" : val.email
      };*/
//      databaseService.uploadUserInfo(userInfoMap);
      databaseService.uploadUserInfo(val.toJson());

      val.isLogged = true;
      optionStorageService.save('user', val.toJson());
      Navigator.pushReplacement(context, MaterialPageRoute(
          builder: (context) => ChatRoom()
      ));
    });
  }

  void loadData(){
    notifyListeners();
  }
}