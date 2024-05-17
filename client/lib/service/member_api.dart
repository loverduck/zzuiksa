import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:client/constants.dart';
import 'package:client/screens/profile/model/member_model.dart';

class MemberApi with ChangeNotifier {
  Member? _member;
  get member => _member;

  MemberApi() {
    getMemberInfo();
  }

  static const storage = FlutterSecureStorage();
  String? token;

  Future<void> getToken() async {
    dynamic userInfo = await storage.read(key: "login");
    token = json.decode(userInfo)['accessToken'];
  }

  Future<void> getMemberInfo() async {
    await getToken();

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
        // print(utf8.decode(res.bodyBytes));
        _member =
            Member.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
        notifyListeners();
      } else {
        throw Exception('get member info failed statusCode: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception("get member info error: $e");
    }
  }

  Future<void> updateMemberInfo(Member member) async {
    await getToken();

    try {
      final res = await http.patch(
        Uri.parse("$baseUrl/api/members"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(member.toJson()),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        // print(res.body);
        // print(utf8.decode(res.bodyBytes));
        _member =
            Member.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
        notifyListeners();
      } else {
        throw Exception(
            'update member info failed statusCode: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception("update member info error: $e");
    }
  }
}
