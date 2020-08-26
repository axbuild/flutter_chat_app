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
  String imageUrl;
  final picker = ImagePicker();

  void loadData() async {

      await storage.loadImage('user/self_image/${Local.user.sid}')
          .then((value){
        imageUrl = value;
        if(Local.user.photoUrl == null)
        {
          Local.user.photoUrl = value;
        }
        notifyListeners();
      })
          .catchError((error, stackTrace) {
        print("outer: $error");
      });


    notifyListeners();
  }

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery)
        .then((value){
      notifyListeners();
    });

    image = File(pickedFile.path);
    print('Image Path $image');
    notifyListeners();
  }

  Future uploadPic() async{
//    String fileName = basename(image.path);
    return await storage.upload(image, 'user/self_image', Local.user.sid)
    .then((value){
      imageUrl = value;
      Local.user.photoUrl = value;
      print(url);
      notifyListeners();
      return value;
    });
  }

}