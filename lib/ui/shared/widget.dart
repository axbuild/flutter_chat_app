import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/authenticate.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/business_logic/utils/universal_variables.dart';
import 'package:chatapp/business_logic/view_models/rooms_screen_viewmodel.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Row(
      children: <Widget>[
        Icon(
            Icons.verified_user,
            color: Colors.white,
            size: 28.0
        ),
        Spacer(flex:2),
        Text('Sign in')
      ],
    ),
  );
}

//    title: Image.asset("assets/images/logo.png", height:50),
//    title: Image.asset("assets/images/logo.png", height:50),

InputDecoration textFieldInputDecoration(String hintText){
  return  InputDecoration(
      hintText: hintText,
      hintStyle: TextStyle(
          color: Colors.grey
      ),
      focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff39796b))
      ),
      enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Color(0xff39796b))
      ),
  );
}

TextStyle simpleTextStyle(){
  return TextStyle(
    color: Colors.black,
    fontSize:18
  );
}

TextStyle mediumTextStyle(){
  return TextStyle(
      color: Colors.black,
      fontSize:20
  );
}

TextStyle mediumInputFieldStyle(){
  return TextStyle(
      color: Colors.black,
      fontSize:20
  );
}

TextStyle mediumBtnStyle(){
  return TextStyle(
      color: Colors.white,
      fontSize:20
  );
}

Drawer drawer(BuildContext context, RoomsScreenViewModel model){

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text("You: ${Local.user.name}", style: TextStyle(
            color: Colors.white,
            fontSize: 17
          )),
          decoration: BoxDecoration(
            color: Color(UniversalVariables.primeColor),
          ),
        ),
        ListTile(
          title: Row(
            children: <Widget>[
              Text('Profile'),
              Spacer(flex: 2),
              Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 28.0
              ),
            ],
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Row(
            children: <Widget>[
              Text('Balance'),
              Spacer(flex: 2),
              Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 28.0
              ),
            ],
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Row(
            children: <Widget>[
              Text('Settings'),
              Spacer(flex: 2),
              Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 28.0
              ),
            ],
          ),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Row(
            children: <Widget>[
              Text('Sing out'),
              Spacer(flex: 2),
              Icon(
                  Icons.keyboard_arrow_right,
                  color: Colors.black,
                  size: 28.0
              ),
            ],
          ),
          onTap: () {
            model.signOut();
            Navigator.pushReplacement(context, MaterialPageRoute(
                builder: (context) => Authenticate()
            ));
          },
        )
      ],
    ),
  );
}

Future<void> showPopUpDialog(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false, // user must tap button!
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Alert'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(text),
//              Text('Would you like to approve of this message?'),
            ],
          ),
        ),
        actions: <Widget>[
          FlatButton(
            child: Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

//Future<void> showLoadingDialog(BuildContext context, GlobalKey key) async {
//    return showDialog<void>(
//      context: context,
//      barrierDismissible: false,
//      builder: (BuildContext context) {
//        return new WillPopScope(
//          onWillPop: () async => false,
//          child: SimpleDialog(
//            key: key,
//            backgroundColor: Colors.black54,
//            children: <Widget>[
//            Center(
//              child: Column(children: [
//                CircularProgressIndicator(),
//                SizedBox(height: 10,),
//                Text("Please Wait....",style: TextStyle(color: Colors.blueAccent),)
//              ]),
//            )
//        ]));
//    });
//}

