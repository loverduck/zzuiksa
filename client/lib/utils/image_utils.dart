import 'dart:io';
import 'package:flutter/material.dart';

class ImageUtils {
  static Image loadImage(String filePath) {
    return Image.file(File(filePath));
  }

  static Future<void> saveImageToLocal(String imageUrl, String savePath) async {
    // URL로부터 HttpClientRequest 생성
    final request = await HttpClient().getUrl(Uri.parse(imageUrl));
    // Request를 발송하고 Response 객체를 받음
    final response = await request.close();

    // HttpClientResponse가 파일로 저장될 수 있도록 FileStream과 연결
    final bytes = await response.fold<BytesBuilder>(BytesBuilder(), (b, d) => b..add(d));
    File file = File(savePath);
    await file.writeAsBytes(bytes.takeBytes());
  }
}
