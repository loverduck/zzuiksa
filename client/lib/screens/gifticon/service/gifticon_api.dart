import 'dart:async';
import 'dart:convert';

import 'package:client/constants.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

import '../model/gifticon_preview_model.dart';

Future<Gifticon> postGifticon(Gifticon gifticon) async {
  const storage = FlutterSecureStorage();
  dynamic userInfo = await storage.read(key: 'login');
  String token = json.decode(userInfo)['accessToken'];

  try {
    final res = await http.post(
      Uri.parse("$baseUrl/api/gifticons"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(gifticon.toJson()),
    );
    if (res.statusCode == 200) {
      return Gifticon.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
    } else {
      throw Exception('Failed to create gifticon.');
    }
  } catch (e) {
    throw Exception("create gifticon error: $e");
  }
}

Future<Gifticon> getGifticonDetail(int gifticonId) async {
  const storage = FlutterSecureStorage();
  dynamic userInfo = await storage.read(key: 'login');
  String token = json.decode(userInfo)['accessToken'];

  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return Gifticon.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
    } else {
      throw Exception('Failed to load gifticon detail.');
    }
  } catch (e) {
    throw Exception('gifticon detail error: $e');
  }
}

Future<List<GifticonPreview>> getGifticonList() async {
  const storage = FlutterSecureStorage();
  dynamic userInfo = await storage.read(key: 'login');
  String token = json.decode(userInfo)['accessToken'];

  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/gifticons"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    if (res.statusCode == 200) {
      List<dynamic> jsonData = json.decode(utf8.decode(res.bodyBytes));
      return jsonData.map((item) => GifticonPreview.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load gifticon list.');
    }
  } catch (e) {
    throw Exception('load gifticon list error: $e');
  }
}

Future<Gifticon> patchGifticon(int gifticonId, Gifticon gifticon) async {
  const storage = FlutterSecureStorage();
  dynamic userInfo = await storage.read(key: 'login');
  String token = json.decode(userInfo)['accessToken'];

  try {
    final res = await http.patch(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(gifticon.toJson()),
    );

    if (res.statusCode == 200) {
      return Gifticon.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
    } else {
      throw Exception('Failed to update gifticon.');
    }
  } catch (e) {
    throw Exception('update gifticon error: $e');
  }
}

Future<bool> deleteGifticon(int gifticonId) async {
  const storage = FlutterSecureStorage();
  dynamic userInfo = await storage.read(key: 'login');
  String token = json.decode(userInfo)['accessToken'];

  try {
    final res = await http.delete(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return true;
    } else {
      throw Exception('Failed to delete gifticon.');
    }
  } catch (e) {
    throw Exception('delelte gifticon error: $e');
  }
}