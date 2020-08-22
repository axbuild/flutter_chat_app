import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/authenticate.dart';
import 'package:chatapp/business_logic/utils/helper.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/business_logic/view_models/rooms_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/screens/chat_room_screen.dart';
import 'package:chatapp/ui/screens/search_screen.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class RoomsScreen extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<RoomsScreen> {

  RoomsScreenViewModel model = serviceLocator<RoomsScreenViewModel>();
  Room room;
  Map<String, dynamic> interlocutor;
  String incomingMessage;

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RoomsScreenViewModel>(
      create: (context) => model,
      child: Consumer<RoomsScreenViewModel>(
          builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text('contacts'),//Icon(Icons.list),
              actions: [
//                GestureDetector(
//                  onTap: (){
//                    model.signOut();
//                    Navigator.pushReplacement(context, MaterialPageRoute(
//                        builder: (context) => Authenticate()
//                    ));
//                  },
//                  child: Container(
//                      padding: EdgeInsets.symmetric(horizontal: 16),
//                      child: Icon(Icons.exit_to_app)
//                  ),
//                )
              ],
            ),
            body: chatRoomList(model),
            drawer: drawer(context, model),
            floatingActionButton: FloatingActionButton(
              backgroundColor: Color(0xff39796b),
              child: Icon(Icons.search),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                    builder: (context) => SearchScreen()
                ));
              },
            ),
          )
      )
    );

  }

  Widget chatRoomList(RoomsScreenViewModel model){
//   print("~~~~~${model.streamUsers.isEmpty}");
      String userType = '';
      return StreamBuilder(
      stream: model.streamRooms,
      builder: (context, snapshot){
        print('~~~~~~~~~');
        if(snapshot.hasData){
          print(snapshot.data.documents.length);
        };
        return snapshot.hasData ? ListView.builder(
          itemCount: snapshot.data.documents.length,
          itemBuilder: (context, index){

            room = Room.fromMap(snapshot.data.documents[index].data);
            interlocutor = Helper().getIntelocutor(room);
//            incomingMessage = (interlocutor["isIncomingCall"] != null) ? 'income' : '-';

            return ChatRoomTile(
                new User(
                    sid: interlocutor["sid"],
                    name:interlocutor["name"]
                )
            );
          },
        ) : //Container()
        Shimmer.fromColors(
          child: ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Icon(Icons.account_circle, size: 50.0),
                title: SizedBox(
                  child: Container(
                    color: Colors.green,
                  ),
                  height: 10.0,
                ),
              );
            },
          ),
          baseColor: Colors.grey,
          highlightColor: Colors.teal,
        );
      },
    );
  }
}

//ListTile ChatRoomTile(User user) => ListTile(
//  title: Text(user.name,
//      style: TextStyle(
//        fontWeight: FontWeight.w500,
//        fontSize: 20,
//      )),
//  subtitle: Text(user.name),
//  leading: Icon(
//      Icons.account_circle,
//      size: 50.0,
//      color: Color(0xff39796b)
//  ),
//);

class ChatRoomTile extends StatelessWidget {
  final User user;
  ChatRoomTile(this.user);

  @override
  Widget build(BuildContext context) {

    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ChatRoomScreen(user)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: <Widget>[
            Container(
              height: 50,
              width: 50,
              alignment: Alignment.center,
//              decoration: BoxDecoration(
//                color: Color(0xff39796b),
//                borderRadius: BorderRadius.circular(40)
//              ),
              child: Row(
                children: <Widget>[
                  Icon(Icons.account_circle, size: 50.0, color: Color(0xff39796b)),
                ],
              )
            ),
            SizedBox(width: 8,),
            Text(user.name, style: mediumTextStyle())
          ],
        ),
      ),
    );
  }
}
