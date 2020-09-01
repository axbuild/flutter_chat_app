import 'dart:io';

import 'package:flutter/painting.dart';

abstract class FileStorageService {
  @override
  Future<String> upload(File file, String path, String filename);
  Future<String> loadImage(String image);
  Future<NetworkImage> loadNetworkImage(String image);
}