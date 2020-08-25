import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

import 'file_storage_service.dart';

class FileStorageServiceFileStorage extends FileStorageService{

  Future<String> upload(File file, String path, String filename) async{
    StorageReference storageReference;
//    if (fileType == 'image') {
//      storageReference =
//          FirebaseStorage.instance.ref().child("images/$filename");
//    }
//    if (fileType == 'audio') {
//      storageReference =
//          FirebaseStorage.instance.ref().child("audio/$filename");
//    }
//    if (fileType == 'video') {
//      storageReference =
//          FirebaseStorage.instance.ref().child("videos/$filename");
//    }
//    if (fileType == 'pdf') {
//      storageReference =
//          FirebaseStorage.instance.ref().child("pdf/$filename");
//    }
//    if (fileType == 'others') {
//      storageReference =
//          FirebaseStorage.instance.ref().child("others/$filename");
//    }
    storageReference =
        FirebaseStorage.instance.ref().child("$path/$filename");
    final StorageUploadTask uploadTask = storageReference.putFile(file);
    final StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    final String url = (await downloadUrl.ref.getDownloadURL());
    return url;
  }

  Future<String> loadImage(String image) async {
    StorageReference storageReference;
    storageReference = FirebaseStorage.instance.ref().child(image);

    return storageReference != null ?
      storageReference.getDownloadURL().toString() : '';
//        .then((value) => value)
//        .catchError((error, stackTrace) {
//          return
//        });
  }
  
}