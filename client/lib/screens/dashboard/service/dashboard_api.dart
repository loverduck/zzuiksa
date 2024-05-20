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
  await getToken();

  try {
    var res = await http.get(
      Uri.parse("$baseUrl/api/schedules/summary"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
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

Future<void> endSchedule(int scheduleId) async {
  await getToken();

  Schedule schedule = await getSchedule(scheduleId);

  try {
    schedule.scheduleId = scheduleId;
    schedule.isDone = true;
    var res = await http.patch(
      Uri.parse("$baseUrl/api/schedules/$scheduleId"),
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

Future<dynamic> getSchedule(int scheduleId) async {
  await getToken();

  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/schedules/$scheduleId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    if (res.statusCode == 200) {
      return Schedule.fromJson(json.decode(utf8.decode(res.bodyBytes))['data']);
    } else {
      throw Exception('get place info failed statusCode: ${res.statusCode}');
    }
  } catch (e) {
    throw Exception("get place info error: $e");
  }
}