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

