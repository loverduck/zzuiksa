import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'package:client/constants.dart';
import 'package:client/screens/profile/model/place_model.dart';

const storage = FlutterSecureStorage();
String token = '';

Future<dynamic> getPlaceInfo(int placeId) async {
  try {
    dynamic userInfo = await storage.read(key: 'login');
    token = json.decode(userInfo)['accessToken'];

    final res = await http.get(
      Uri.parse("$baseUrl/api/places/$placeId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      // print(res.body);
      // print(utf8.decode(res.bodyBytes));
      return Place.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
    } else {
      throw Exception('get place info failed statusCode: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception("get place info error: $e");
  }
}

Future<void> createPlaceInfo(Place place) async {
  try {
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
      print(utf8.decode(res.bodyBytes));
    } else {
      throw Exception('create place info failed statusCode: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception("create place info error: $e");
  }
}


Future<void> deletePlaceInfo(int placeId) async {
  try {
    dynamic userInfo = await storage.read(key: 'login');
    token = json.decode(userInfo)['accessToken'];

    final res = await http.delete(
      Uri.parse("$baseUrl/api/places/$placeId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode >= 200 && res.statusCode < 300) {
      print(utf8.decode(res.bodyBytes));
    } else {
      throw Exception('create place info failed statusCode: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception("create place info error: $e");
  }
}

  Future<dynamic> getPlaceList() async {
    try {
      print('getPlaceList()');

      dynamic userInfo = await storage.read(key: 'login');
      token = json.decode(userInfo)['accessToken'];

      final res = await http.get(
        Uri.parse("$baseUrl/api/places"),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'Bearer $token',
        },
      );

      if (res.statusCode == 200) {
        // print(res.body);
        print(utf8.decode(res.bodyBytes));
        Places places = Places.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
        return places.places;
      } else {
        throw Exception('get place list failed statusCode: ${res.statusCode}');
      }
    } catch (e) {
      throw Exception("get place list error: $e");
    }
  }
