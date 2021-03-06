import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/business_logic/view_models/chat_room_screen_viewmodel.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/ui/shared/widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatRoomScreen extends StatefulWidget {
  final User user;

  ChatRoomScreen(this.user);

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatRoomScreen> {

  ChatRoomScreenViewModel model = serviceLocator<ChatRoomScreenViewModel>();

  TextEditingController messageController;

  Widget ChatMessageList(model){
      return StreamBuilder(
        stream: model.chatMessagesStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.builder(
              itemCount: snapshot.data.documents.length,
              itemBuilder: (context, index){
                return MessageTile(
                  snapshot.data.documents[index].data["text"],
                    snapshot.data.documents[index].data["author"] == Local.user.sid
                );
              }) : Container();
        },
      );
  }

  @override
  void initState() {
    model.loadData(widget.user);
    messageController = new TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChatRoomScreenViewModel>(
        create: (context) => model,
          child: Consumer<ChatRoomScreenViewModel>(
            builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: Row(
                  children: <Widget>[
                    Text(widget.user.name ?? 'undefined'),
                    Spacer(flex:2),
                    IconButton(
                      icon: Icon(Icons.call),
                      onPressed: () {

                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.video_call),
                      onPressed: () {

                      },
                    ),
                  ],
                ),
              ),
              body: Container(
                child: Stack(
                  children: <Widget>[
                    ChatMessageList(model),
                    Container(
                      alignment: Alignment.bottomCenter,
                      child: Container(
                        padding: EdgeInsets.symmetric(horizontal: 18, vertical: 16),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: messageController,
                                decoration: textFieldInputDecoration('Message...'),
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                if(messageController.text.isNotEmpty) {
                                  model.sendMessage(messageController.text);
                                  messageController.text = "";
                                }
                              },
                              child: Icon(
                                  Icons.send,
                                  color: Colors.black38,
                                  size: 28.0
                              ),
                            ),

                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            )
      )
    );
  }

}

class MessageTile extends StatelessWidget {
  final String message;
  final bool isSendByMe;
  MessageTile(this.message, this.isSendByMe);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: isSendByMe ? 0 : 24,  right: isSendByMe ? 24 : 0),
      margin: EdgeInsets.symmetric(vertical: 6),
      width: MediaQuery.of(context).size.width,
      alignment: isSendByMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        decoration: BoxDecoration(
            color: isSendByMe ? Colors.blueGrey : Colors.blue,
            borderRadius: isSendByMe ?
              BorderRadius.only(
                  topLeft: Radius.circular(23),
                  topRight: Radius.circular(23),
                  bottomLeft: Radius.circular(23),
              ) :
              BorderRadius.only(
                topLeft: Radius.circular(23),
                topRight: Radius.circular(23),
                bottomRight: Radius.circular(23),
              )
        ),
        child: Text(message, style: TextStyle(
          color: Colors.white,
          fontSize: 17
        ),),
      ),
    );
  }
}
