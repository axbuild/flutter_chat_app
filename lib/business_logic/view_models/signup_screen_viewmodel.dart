import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:chatapp/services/storage/option_storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreenViewModel extends ChangeNotifier {


  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();

  DatabaseService storageService = serviceLocator<DatabaseService>();
  OptionStorageService optionStorageService = serviceLocator<OptionStorageService>();
  User user;

  final formKey = GlobalKey<FormState>();
  TextEditingController userNameTextEditingController = new TextEditingController();
  TextEditingController emailTextEditingController = new TextEditingController();
  TextEditingController passwordTextEditingController = new TextEditingController();

  void signMeUp(BuildContext context){
    if(formKey.currentState.validate()) {

      isLoading = true;

      Map<String, String> userInfoMap = {
        "name" : userNameTextEditingController.text,
        "email" : emailTextEditingController.text,
        "token" : Constants.token
      };

//      Options.saveUserEmail(emailTextEditingController.text);
//      Options.saveUserName(userNameTextEditingController.text);

      user.name = userNameTextEditingController.text;
      user.email = emailTextEditingController.text;
      optionStorageService.save('user', user.toJson());

      authMethods.signUpwithEmailAndPassword( emailTextEditingController.text,
          passwordTextEditingController.text
      ).then((val){

        storageService.uploadUserInfo(userInfoMap);

        user.isLogged = true;
        optionStorageService.save('user', user.toJson());
//        Options.saveUserLogged(true);
        Navigator.pushReplacement(context, MaterialPageRoute(
            builder: (context) => ChatRoom()
        ));
      });
    }
  }

  void loadData(){
    notifyListeners();
  }
}