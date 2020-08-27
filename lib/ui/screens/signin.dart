import 'dart:math';
import 'dart:ui';
import 'package:chatapp/business_logic/view_models/signin_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
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

  ButtonState stateTextWithIcon = ButtonState.idle;

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  Widget buildTextWithIcon(Function onPressedFunction, ButtonState stateTextWithIcon) {
    return ProgressButton.icon(iconedButtons: {
      ButtonState.idle: IconedButton(
          text: "Send",
          icon: Icon(Icons.send, color: Colors.white),
          color: Colors.deepPurple.shade500),
      ButtonState.loading: IconedButton(
          text: "Loading",
          color: Colors.deepPurple.shade700),
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
    }, onPressed: onPressedFunction, state: stateTextWithIcon);
  }

  void onPressedIconWithText() {
    switch (stateTextWithIcon) {
      case ButtonState.idle:
        stateTextWithIcon = ButtonState.loading;

        Future.delayed(Duration(seconds: 1), () {
          setState(() {
            stateTextWithIcon = Random.secure().nextBool()
                ? ButtonState.success
                : ButtonState.fail;
          });
        });

        break;
      case ButtonState.loading:
        break;
      case ButtonState.success:
        stateTextWithIcon = ButtonState.idle;
        break;
      case ButtonState.fail:
        stateTextWithIcon = ButtonState.idle;
        break;
    }
    setState(() {
      stateTextWithIcon = stateTextWithIcon;
    });
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
                GestureDetector(
                  onTap: () async {
                   model.signIn(context);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Color(0xff39796b),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign In",
                      style: mediumBtnStyle(),
                    ),
                  ),
                ),
                SizedBox(height:8,),
                GestureDetector(
                  onTap: () {
                      model.signInWithGoogle(context);
                      print('Sign in with Google');
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: MediaQuery.of(context).size.width,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text("Sign In with Google",
                      style: mediumBtnStyle(),
                    ),
                  ),
                ),
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
                buildTextWithIcon(onPressedIconWithText, stateTextWithIcon)
              ],
            ),
          ),
        ),
      ),
    );
  }

}
