import 'dart:io';

abstract class FileStorageService {
  @override
  Future<String> upload(File file, String path, String filename);
  Future<String> loadImage(String image);
}