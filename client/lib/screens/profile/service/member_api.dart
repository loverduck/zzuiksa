import 'dart:convert';

import 'package:client/constants.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import '../model/member_model.dart';

Future<Member> getMember() async {
  const storage = FlutterSecureStorage();
  dynamic userInfo = await storage.read(key: 'login');
  String token = json.decode(userInfo)['accessToken'];

  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/members"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      // print(res.body);
      // return Member.fromJson(json.decode(res.body)['data']);
      print(utf8.decode(res.bodyBytes));
      return Member.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
    } else {
      throw Exception('get member info failed');
    }
  } catch (e) {
    throw Exception("get member info error: $e");
  }
}