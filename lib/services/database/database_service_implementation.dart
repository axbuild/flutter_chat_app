import 'package:chatapp/business_logic/models/message.dart';
import 'package:chatapp/business_logic/models/room.dart';
import 'package:chatapp/business_logic/models/user.dart';
import 'package:chatapp/services/database/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseServiceImpl implements DatabaseService{

  static CollectionReference _roomsRef = Firestore.instance.collection("rooms");
  static CollectionReference _usersRef = Firestore.instance.collection("users");

  @override
  Future<Message> addConversationMessages(String chatRoomId, messageMap) {
    _roomsRef
        .document(chatRoomId)
        .collection("chats")
        .add(messageMap).catchError((e){
      print(e.toString());
    });
  }

  @override
  Future<Room> createChatRoom(Room room, chatRoomMap) async {
    if(room.id != null){
      await _roomsRef
          .document(room.id)
          .setData(chatRoomMap);
    }else{
      await _roomsRef.add(chatRoomMap)
          .then((ref){
        room.id = ref.documentID;
      })
          .catchError((e){
        print(e.toString());
      });
    }
    return room;
  }

  Future<Room> getRoom(User user1, User user2) async {
    Room room = new Room();
    print('&&&&&&&&&&&&&&&&&&&&&&&');
    print(user1.sid);
    print('&&&&&&&&&&&&&&&&&&&&&&&');
    await _roomsRef
        .where("time", isEqualTo: "1595534994034")
//        .where("users."+user1.sid, isEqualTo: true)
//        .where("users."+user2.sid, isEqualTo: true)
        .snapshots()
        .listen((data) =>
            data.documents.forEach(
                    (doc){
                      print('^^^^^^^^^^^^^');
                      print(doc.documentID);
                    }
            )
        );
//        .listen((data) {
//
//            room.id =  data.documents[0].documentID;
//            print("______________-${room.id}");
//        });
//        .getDocuments()
//        .then((snapshot){
//           room.id =  snapshot.documents[0].documentID;
//    });
    return room;
  }

  @override
  Future<Stream> getChatRooms(String userName) async {
    return await _roomsRef
        .where("users", arrayContains: userName)
        .snapshots();
  }

  @override
  Future<Stream> getConversationMessages(String chatRoomId) async {

   return await _roomsRef
        .document(chatRoomId)
        .collection("chats")
        .orderBy("time", descending: false)
        .snapshots();
  }

  @override
  Future<User> getUserByEmail(String userEmail) async {
    User user = User();
    await _usersRef
        .where("email", isEqualTo: userEmail )
        .getDocuments()
        .then((snapshot){
            user.sid = snapshot.documents[0].documentID;
            user.name = snapshot.documents[0].data['name'];
            user.email = snapshot.documents[0].data['email'];
            user.isLogged = true;
        });
    return user;
  }

  @override
  Future<bool> uploadUserInfo(userMap) {
    _usersRef
        .add(userMap).catchError((e){
      print(e.toString());
    });
  }

  @override
  Future<List<User>> getUserByName(String userName) async {

    List<User> users = [];

    await _usersRef
        .where("name", isEqualTo: userName )
        .getDocuments()
        .then((snapshot){

        snapshot.documents.forEach((element) {
                users.add(User(
                  sid: element.documentID,
                  name: element.data['name'],
                  email: element.data['email']
                ));
        });
      });

    return users;
  }
  
}