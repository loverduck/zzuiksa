import 'dart:io';
import 'package:flutter/material.dart';

class ImageUtils {
  static Future<File> loadImage(String filePath) async {
    print("loadImage");
    return File(filePath);
  }
}
