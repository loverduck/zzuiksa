import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:client/screens/gifticon/model/gifticon_ocr_request_model.dart';

class GifticonOcrApi {
  final String _invokeUrl = dotenv.env['CLOVA_OCR_INVOKE_URL'] ?? '';
  final String _secretKey = dotenv.env['CLOVA_OCR_SECRET_KEY'] ?? '';

  Future<Map<String, dynamic>> requestOcr(GifticonOcrRequestModel model) async {
    final response = await http.post(
      Uri.parse(_invokeUrl),
      headers: {
        'Content-Type': 'application/json',
        'X-OCR-SECRET': _secretKey,
      },
      body: model.toRawJson(),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body) as Map<String, dynamic>;
    } else {
      throw HttpException(
        'Failed to perform OCR. Status code: ${response.statusCode}',
        uri: Uri.parse(_invokeUrl),
      );
    }
  }
}
