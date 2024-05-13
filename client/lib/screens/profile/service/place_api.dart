import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:client/constants.dart';
import 'package:client/screens/profile/model/place_model.dart';

class PlaceApi with ChangeNotifier {
  Place? _place;
  get place => _place;

  PlaceApi() {
    // getPlaceInfo();
  }

  String token = '';

  Future<void> getPlaceInfo() async {
    // try {
    //   const storage = FlutterSecureStorage();
    //   dynamic userInfo = await storage.read(key: 'login');
    //   token = json.decode(userInfo)['accessToken'];
    //
    //   final res = await http.get(
    //     Uri.parse("$baseUrl/api/members"),
    //     headers: <String, String>{
    //       'Content-Type': 'application/json; charset=UTF-8',
    //       'Authorization': 'Bearer $token',
    //     },
    //   );
    //
    //   if (res.statusCode == 200) {
    //     // print(res.body);
    //     // print(utf8.decode(res.bodyBytes));
    //     _member =
    //         Member.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
    //     notifyListeners();
    //   } else {
    //     throw Exception('get member info failed statusCode: ${res.statusCode}');
    //   }
    // } catch (e) {
    //   throw Exception("get member info error: $e");
    // }
  }

  Future<void> createPlaceInfo(Place place) async {
    try {
      const storage = FlutterSecureStorage();
      dynamic userInfo = await storage.read(key: 'login');
      token = json.decode(userInfo)['accessToken'];

      final res = await http.post(
        Uri.parse("$baseUrl/api/places"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
        body: jsonEncode(place.toJson()),
      );

      if (res.statusCode >= 200 && res.statusCode < 300) {
        // print(res.body);
        // print(utf8.decode(res.bodyBytes));
        _place =
            Place.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
        notifyListeners();
      } else {
        throw Exception(
            'create place info failed statusCode: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception("create place info error: $e");
    }
  }
}
