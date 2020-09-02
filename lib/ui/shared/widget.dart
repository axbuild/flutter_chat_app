import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/authenticate.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/business_logic/utils/universal_variables.dart';
import 'package:chatapp/business_logic/view_models/rooms_screen_viewmodel.dart';
import 'package:chatapp/ui/screens/pickup_room_screen.dart';
import 'package:chatapp/ui/screens/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:progress_state_button/iconed_button.dart';
import 'package:progress_state_button/progress_button.dart';

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
            decoration: BoxDecoration(
                gradient: LinearGradient(colors: <Color>[
                  Color(UniversalVariables.primeColor),
                  Color(UniversalVariables.lightColor)
                ])
            ),
            child: Container(
              child: Column(
                children: <Widget>[
                  Material(
                    borderRadius: BorderRadius.all(Radius.circular(50.0)),
                    elevation: 10,
                    child: Padding(padding: EdgeInsets.all(1.0),
                      child:
                      // Local.user.photoUrl != null ? CircleAvatar(
                      //   radius: 50.0,
                      //   backgroundImage: NetworkImage(Local.user.photoUrl),
                      // ) :
                      Icon(
                        Icons.account_circle,
                        color: Colors.blueGrey,
                        size: 100.0,
                      ),
                    ),
                  ),
                  // Text(Local.user.name, style: TextStyle(color: Colors.white, fontSize: 25.0),)
                  Text("nick name", style: TextStyle(color: Colors.white, fontSize: 25.0),)
                ],
              ),
            )),
        CustomListTile(Icons.person, 'Profile', ()=>{
          Navigator.pop(context),
          Navigator.push(context,
              new MaterialPageRoute(builder: (context) => new ProfileScreen())
          )
        }),
        CustomListTile(Icons.calendar_today, 'Activity', ()=>{
          Navigator.pop(context),
          Navigator.push(context,
             new MaterialPageRoute(builder: (context) => new PickupRoomScreen())
         )
//          Navigator.pop(context),
//          Navigator.push(context,
//              new MaterialPageRoute(builder: (context) => new NotificationView())
//          )
        }),
        CustomListTile(Icons.settings, 'Settings', ()=>{}),
        CustomListTile(Icons.lock, 'Log Out', ()=>{
          model.signOut(),
          Navigator.pushReplacement(context, MaterialPageRoute(
              builder: (context) => Authenticate()
          ))
        }),
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


class CustomListTile extends StatelessWidget{

  final IconData icon;
  final  String text;
  final Function onTap;

  CustomListTile(this.icon, this.text, this.onTap);
  @override
  Widget build(BuildContext context){
    //ToDO
    return Padding(
      padding: const EdgeInsets.fromLTRB(8.0, 0, 8.0, 0),
      child:Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey.shade400))
        ),
        child: InkWell(
            splashColor: Colors.orangeAccent,
            onTap: onTap,
            child: Container(
                height: 40,
                child: Row(
                  mainAxisAlignment : MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(children: <Widget>[
                      Icon(icon),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                      ),
                      Text(text, style: TextStyle(
                          fontSize: 16
                      ),),
                    ],),
                    Icon(Icons.arrow_right)
                  ],)
            )
        ),
      ),
    );
  }
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

// Widget buildProgressButtonTextWithIcon(Function onPressedFunction, ButtonState stateTextWithIcon) {
//   return ProgressButton.icon(iconedButtons: {
//     ButtonState.idle: IconedButton(
//         text: "Go",
//         icon: Icon(Icons.send, color: Colors.white),
//         color: Colors.deepPurple.shade500),
//     ButtonState.loading: IconedButton(
//         text: "Loading",
//         color: Colors.deepPurple.shade700),
//     ButtonState.fail: IconedButton(
//         text: "Failed",
//         icon: Icon(Icons.cancel, color: Colors.white),
//         color: Colors.red.shade300),
//     ButtonState.success: IconedButton(
//         text: "Success",
//         icon: Icon(
//           Icons.check_circle,
//           color: Colors.white,
//         ),
//         color: Colors.green.shade400)
//   }, onPressed: onPressedFunction, state: stateTextWithIcon);
// }