import 'dart:convert';

import 'package:client/constants.dart';
import 'package:client/screens/gifticon/model/gifticon_model.dart';
import 'package:http/http.dart' as http;

Future<Gifticon> postGifticon(Gifticon gifticon) async {
  try {
    final res = await http.post(
      Uri.parse("$baseUrl/api/gifticons"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(gifticon.toJson()),
    );
    if (res.statusCode == 200) {
      return Gifticon.fromJson(json.decode(res.body));
    } else {
      throw Exception('Failed to create gifticon.');
    }
  } catch (e) {
    throw Exception("create gifticon error: $e");
  }
}

Future<void> getGifticonDetail(int gifticonId) async {
  try {
    final res = await http.get(Uri.parse("$baseUrl/api/gifticons/$gifticonId"));

    print(res);
  } catch (e) {
    print("get schedule error: $e");
  }
}

Future<void> getGifticonList() async {
  try {
    final res = await http.get(Uri.parse("$baseUrl/api/gifticons"));

    print(res);
  } catch (e) {
    print("get schedule error: $e");
  }
}

Future<void> patchGifticon(int gifticonId, Gifticon gifticon) async {
  try {
    final res = await http.patch(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(gifticon.toJson()),
    );

    print(res);
  } catch (e) {
    print("create schedule error: $e");
  }
}

Future<void> deleteGifticon(int gifticonId) async {
  try {
    final res = await http.delete(
      Uri.parse("$baseUrl/api/gifticons/$gifticonId"),
    );

    print(res);
  } catch (e) {
    print("create schedule error: $e");
  }
}