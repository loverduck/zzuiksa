import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:client/constants.dart';
import '../model/statistic_model.dart';

const storage = FlutterSecureStorage();
String? token;

Future<void> getToken() async {
  dynamic userInfo = await storage.read(key: "login");
  token = json.decode(userInfo)['accessToken'];
}

Future<dynamic> getStatistic() async {
  await getToken();

  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/schedules/statistics"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      // print(res.body);
      print(utf8.decode(res.bodyBytes));
      Map<String, dynamic> resbody = json.decode(utf8.decode(res.bodyBytes));
      Statistic statistic = Statistic.fromJson(resbody['data']);
      return statistic;
    } else {
      throw Exception('get statistic failed statusCode: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception("get statistic error: $e");
  }
}
