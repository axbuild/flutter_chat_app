import 'package:chatapp/business_logic/utils/local.dart';
import 'package:flutter/material.dart';

Widget appBarMain(BuildContext context){
  return AppBar(
    title: Row(
      children: <Widget>[
        Icon(
            Icons.supervised_user_circle,
            color: Colors.white,
            size: 28.0
        ),
        Spacer(flex:2),
        Text(
          'Chat App'
        )
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

Drawer drawer(){

  return Drawer(
    child: ListView(
      padding: EdgeInsets.zero,
      children: <Widget>[
        DrawerHeader(
          child: Text("You: ${Local.user.name}"),
          decoration: BoxDecoration(
            color: Colors.blue,
          ),
        ),
        ListTile(
          title: Text('Item 1'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
        ListTile(
          title: Text('Item 2'),
          onTap: () {
            // Update the state of the app.
            // ...
          },
        ),
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

