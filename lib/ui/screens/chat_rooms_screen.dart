import 'package:chatapp/business_logic/utils/authenticate.dart';
import 'package:chatapp/business_logic/utils/constants.dart';
import 'package:chatapp/business_logic/view_models/chat_rooms_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/screens/conversation_screen.dart';
import 'package:chatapp/ui/screens/search.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoom extends StatefulWidget {
  @override
  _ChatRoomState createState() => _ChatRoomState();
}

class _ChatRoomState extends State<ChatRoom> {

  ChatRoomsScreenViewModel model = serviceLocator<ChatRoomsScreenViewModel>();

  @override
  void initState() {
    model.loadData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatRoomsScreenViewModel>(
      create: (context) => model,
      child: Consumer<ChatRoomsScreenViewModel>(
          builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: Text(model.title),//Icon(Icons.list),
              actions: [
                GestureDetector(
                  onTap: (){
                    model.signOut();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => Authenticate()
                    ));
                  },
                  child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Icon(Icons.exit_to_app)
                  ),
                )
              ],
            ),
            body: chatRoomList(model),
            drawer: drawer(),
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

  Widget chatRoomList(ChatRoomsScreenViewModel model){
//   print("~~~~~${model.streamUsers.isEmpty}");

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
            return ChatRoomTile(
                snapshot.data.documents[index].data["id"],
                snapshot.data.documents[index].data["name"]
//                snapshot.data.documents[index].data["chatroomid"]
//                    .toString().replaceAll("_", "")
//                    .replaceAll(Constants.myName, ""),
//                snapshot.data.documents[index].data["chatroomid"]
            );
          },
        ) : Container();
      },
    );
  }
}

class ChatRoomTile extends StatelessWidget {
  final String userName;
  final String chatRoomId;
  ChatRoomTile(this.userName, this.chatRoomId);

  @override
  Widget build(BuildContext context) {
    print('________________');
    return GestureDetector(
      onTap:(){
        Navigator.push(context, MaterialPageRoute(
          builder: (context) => ConversationScreen(chatRoomId)
        ));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Row(
          children: <Widget>[
            Container(
              height: 40,
              width: 40,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Color(0xff39796b),
                borderRadius: BorderRadius.circular(40)
              ),
              child: Text("${userName.substring(0,1).toLowerCase()}",
                  style: mediumTextStyle())
            ),
            SizedBox(width: 8,),
            Text(userName, style: mediumTextStyle())
          ],
        ),
      ),
    );
  }
}
