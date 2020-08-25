import 'dart:io';

import 'package:chatapp/business_logic/utils/local.dart';
import 'package:chatapp/services/service_locator.dart';
import 'package:chatapp/services/storage/file_storage_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';

class ProfileScreenViewModel extends ChangeNotifier {

  FileStorageService storage = serviceLocator<FileStorageService>();

  File image;
  String defaultImageUrl;
  String imageUrl;
  final picker = ImagePicker();

  void loadData() async {
    defaultImageUrl = '';
    imageUrl = '';
    await storage.loadImage('default/no_photo.png')
    .then((value){
      defaultImageUrl = value;
    })
    .catchError((error, stackTrace) {
      print("outer: $error");
    });
    await storage.loadImage('user/self_image/$Local.user.sid')
    .then((value){
      imageUrl = value;
    })
    .catchError((error, stackTrace) {
      print("outer: $error");
    });
    notifyListeners();
  }

  //    test =  FirebaseStorage.instance.ref().child('user/logo_'+Local.user.sid).getDownloadURL();
  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);

    image = File(pickedFile.path);
    print('Image Path $image');
    notifyListeners();
  }

  Future uploadPic() async{
    String fileName = basename(image.path);
    return await storage.upload(image, 'user/self_image', Local.user.sid)
    .then((value){
      imageUrl = value;
      print(url);
      notifyListeners();
      return value;
    });
    notifyListeners();
//
//    StorageReference firebaseStorageRef = FirebaseStorage.instance.ref().child('user/logo_'+Local.user.sid);
//    StorageUploadTask uploadTask = firebaseStorageRef.putFile(_image);
//    StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;
//    setState(() {
//      print("Profile Picture uploaded");
//      Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
//    });
  }

}