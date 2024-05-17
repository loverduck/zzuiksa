import 'dart:async';
import 'dart:convert';

import 'package:client/constants.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import '../model/gifticon_preview_model.dart';

const storage = FlutterSecureStorage();

Future<String?> getToken() async {
  try {
    dynamic userInfo = await storage.read(key: "login");
    return json.decode(userInfo)['accessToken'];
  } catch (e) {
    print("token error: $e");
    return null;
  }
}


Future<dynamic> postGifticon(Gifticon gifticon) async {
  String? token = await getToken();
  if (token == null) {
    print("토큰이 유효하지 않습니다.");
    return;
  }

  try {
    final res = await http.post(
      Uri.parse("$baseUrl/api/gifticons"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(gifticon.toJson()),
    );
    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));
    print(json);
    return json;
  } catch (e) {
    print("create gifticon error: $e");
  }
}

Future<dynamic> getGifticonDetail(int gifticonId) async {
  String? token = await getToken();
  if (token == null) {
    print("토큰이 유효하지 않습니다.");
    return;
  }
  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));
    return json;
  } catch (e) {
    throw Exception('gifticon detail error: $e');
  }
}

Future<List<GifticonPreview>> getGifticonList() async {
  String? token = await getToken();
  if (token == null) {
    print("토큰이 유효하지 않습니다.");
    return [];
  }
  try {
    var res = await http.get(
      Uri.parse("$baseUrl/api/gifticons"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    Iterable json = jsonDecode(res.body) as List;
    return List<GifticonPreview>.from(
        json.map((model) => GifticonPreview.fromJson(model as Map<String, dynamic>))
    );
  } catch (e) {
    print('Error loading gifticon list: $e');
    throw Exception('Failed to load gifticons');
  }
}

Future<dynamic> patchGifticon(int gifticonId, Gifticon gifticon) async {
  String? token = await getToken();
  if (token == null) {
    print("토큰이 유효하지 않습니다.");
    return;
  }
  try {
    final res = await http.patch(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(gifticon.toJson()),
    );

    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));
    return json;
  } catch (e) {
    print('update gifticon error: $e');
  }
}

Future<dynamic> deleteGifticon(int gifticonId) async {
  String? token = await getToken();
  if (token == null) {
    print("토큰이 유효하지 않습니다.");
    return;
  }
  try {
    final res = await http.delete(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));
    return json;
  } catch (e) {
    print('delelte gifticon error: $e');
  }
}