import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/business_logic/utils/helperfunctions.dart';
import 'package:chatapp/services/auth.dart';
import 'package:chatapp/services/database.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/storage_service.dart';
import 'package:chatapp/ui/screens/chat_rooms_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SignUpScreenViewModel extends ChangeNotifier {


  bool isLoading = false;

  AuthMethods authMethods = new AuthMethods();
  DatabaseMethods databaseMethods = new DatabaseMethods();
//  HelperFunctions helperFunctions = new HelperFunctions();
  StorageService storageService = serviceLocator<StorageService>();

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

      HelperFunctions.saveUserEmailInSharedPreference(emailTextEditingController.text);
      HelperFunctions.saveUserNameInSharedPreference(userNameTextEditingController.text);

      authMethods.signUpwithEmailAndPassword( emailTextEditingController.text,
          passwordTextEditingController.text
      ).then((val){

        storageService.uploadUserInfo(userInfoMap);
//        databaseMethods.uploadUserInfo(userInfoMap);
        HelperFunctions.saveUserLoggedInSharedPreference(true);
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