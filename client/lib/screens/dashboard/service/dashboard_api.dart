import 'dart:convert';
import 'package:client/constants.dart';
import 'package:client/screens/dashboard/model/dashboard_model.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();
String? token;

Future<void> getToken() async {
  dynamic userInfo = await storage.read(key: "login");
  token = json.decode(userInfo)['accessToken'];
}

Future<dynamic> getTimeline() async {
  getToken();

  try {
    var res = await http.get(
      Uri.parse("$baseUrl/api/schedules/summary"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      print('get timeline success');
      Map<String, dynamic> resbody = json.decode(utf8.decode(res.bodyBytes));
      Dashboard dashboard = Dashboard.fromJson(resbody['data']);
      return dashboard;
    } else {
      throw Exception('get timeline failed statusCode: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception("get timeline error: $e");
  }
}

Future<void> endSchedule(Schedule schedule) async {
  getToken();

  try {
    schedule.isDone = true;
    print("postSchedule: ${schedule.toJson()}");
    var res = await http.post(
      Uri.parse("$baseUrl/api/schedules/${schedule.scheduleId}"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(schedule.toJson()),
    );

    if (res.statusCode == 200) {
      print('end schedule success');
    } else {
      throw Exception('end schedule failed statusCode: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception("end schedule error: $e");
  }
}
