import 'dart:math';
import 'dart:ui';
import 'package:chatapp/business_logic/utils/universal_variables.dart';
import 'package:chatapp/business_logic/view_models/signin_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/screens/profile_screen.dart';
import 'package:chatapp/ui/screens/rooms_screen.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

class SignIn extends StatefulWidget {
  final Function toggle;
  SignIn(this.toggle);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn>{

  SignInScreenModelView model  = serviceLocator<SignInScreenModelView>();

  ButtonState signInButtonState = ButtonState.idle;
  ButtonState googleSignInButtonState = ButtonState.idle;

  @override
  void initState() {
    model.loadData();
    super.initState();
  }



  // void onPressedIconWithText() {
  //   switch (stateTextWithIcon) {
  //     case ButtonState.idle:
  //       stateTextWithIcon = ButtonState.loading;
  //
  //       Future.delayed(Duration(seconds: 1), () {
  //         setState(() {
  //           stateTextWithIcon = Random.secure().nextBool()
  //               ? ButtonState.success
  //               : ButtonState.fail;
  //         });
  //       });
  //
  //       break;
  //     case ButtonState.loading:
  //       break;
  //     case ButtonState.success:
  //       stateTextWithIcon = ButtonState.idle;
  //       break;
  //     case ButtonState.fail:
  //       stateTextWithIcon = ButtonState.idle;
  //       break;
  //   }
  //   stateTextWithIcon = stateTextWithIcon;
  //   setState(() {
  //     stateTextWithIcon = stateTextWithIcon;
  //   });
  // }

  ProgressButton buildProgressButton(BuildContext context, String text){
    return  ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: text,
          icon: Icon(Icons.exit_to_app, color: Colors.white),
          color: Color(UniversalVariables.primeColor)),
      ButtonState.loading: IconedButton(
          text: "Loading",
          color: Color(UniversalVariables.lightColor)),
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "Success",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: (){
      switch (signInButtonState) {
        case ButtonState.idle:
          signInButtonState = ButtonState.loading;

          model.signIn().then((value) => {
            if(value != null){
              signInButtonState = ButtonState.success,
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => RoomsScreen()
                  // builder: (context) => ProfileScreen()
              ))
            } else {
              signInButtonState = ButtonState.fail,
              showPopUpDialog(context, 'User not found!')
              // Scaffold.of(context).showSnackBar(SnackBar(content: Text('User not found!')))
            }
          });
          break;
        case ButtonState.loading:
          break;
        case ButtonState.success:
          signInButtonState = ButtonState.idle;
          break;
        case ButtonState.fail:
          signInButtonState = ButtonState.idle;
          break;
      }
      signInButtonState = signInButtonState;
      setState(() {
        signInButtonState = signInButtonState;
      });
    }, state: signInButtonState);
  }

  ProgressButton buildGoogleProgressButton(BuildContext context, String text){
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: text,
          icon: Icon(Icons.exit_to_app, color: Colors.white),
          color: Color(UniversalVariables.lightColor)),
      ButtonState.loading: IconedButton(
          text: "Loading",
          color: Color(UniversalVariables.lightColor)),
      ButtonState.fail: IconedButton(
          text: "Failed",
          icon: Icon(Icons.cancel, color: Colors.white),
          color: Colors.red.shade300),
      ButtonState.success: IconedButton(
          text: "Success",
          icon: Icon(
            Icons.check_circle,
            color: Colors.white,
          ),
          color: Colors.green.shade400)
    }, onPressed: (){
      switch (googleSignInButtonState) {
        case ButtonState.idle:
          googleSignInButtonState = ButtonState.loading;

          model.signInWithGoogle().then((value) => {
            if(value != null){
              googleSignInButtonState = ButtonState.success,
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => RoomsScreen()
              ))
            } else {
              googleSignInButtonState = ButtonState.fail,
              showPopUpDialog(context, 'User not found!')
            }
          });
          print('Sign in with Google');
          break;
        case ButtonState.loading:
          break;
        case ButtonState.success:
          googleSignInButtonState = ButtonState.idle;
          break;
        case ButtonState.fail:
          googleSignInButtonState = ButtonState.idle;
          break;
      }
      googleSignInButtonState = googleSignInButtonState;
      setState(() {
        googleSignInButtonState = googleSignInButtonState;
      });
    }, state: googleSignInButtonState);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarMain(context),
      body: SingleChildScrollView(
        child: Container(
          height: MediaQuery.of(context).size.height - 50,
          alignment: Alignment.center,
          child:Container(
            padding: EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                Form(
                  key: model.formKey,
                  child: Column(
                    children: <Widget>[
                      TextFormField(
                        validator: (val){
                          return RegExp(r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,253}[a-zA-Z0-9])?)*$")
                              .hasMatch(val.trim()) ? null : 'Please Provide a valid email';
                        },
                        onChanged: (String txt) {
                          signInButtonState = ButtonState.idle;
                          googleSignInButtonState = ButtonState.idle;
                        },
                        controller: model.emailTextEditingController,
                        style: mediumInputFieldStyle(),
                        decoration: textFieldInputDecoration('email'),
                        textAlign: TextAlign.center,
                      ),
                      TextFormField(
                        obscureText: true,
                        validator: (val){
                          return val.length > 6 ? null: 'Please Provide password 6+ character';
                        },
                        onChanged: (String txt) {
                          signInButtonState = ButtonState.idle;
                          googleSignInButtonState = ButtonState.idle;
                        },
                        controller: model.passwordTextEditingController,
                        style: mediumInputFieldStyle(),
                        decoration: textFieldInputDecoration('password'),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
                SizedBox(height:8,),
                Container(
                  alignment: Alignment.centerRight,
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: Text("ForgotPassword", style: simpleTextStyle(),),
                  ),
                ),
                SizedBox(height: 8,),
                buildProgressButton(context, 'SignIn'),
                SizedBox(height:8,),
                buildGoogleProgressButton(context, 'SignIn with Google'),
                SizedBox(height:8,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Don't have account? ", style: mediumTextStyle(),),
                    GestureDetector(
                      onTap: () {
                        widget.toggle();
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: Text("Register now", style: TextStyle(
                            color: Colors.blueGrey,
                            fontSize: 17,
                            decoration: TextDecoration.underline
                        ),),
                      ),
                    )
                  ],
                ),
                SizedBox(height:8,),
              ],
            ),
          ),
        ),
      ),
    );
  }

}
