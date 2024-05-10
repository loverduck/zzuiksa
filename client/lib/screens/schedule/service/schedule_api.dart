import 'dart:convert';
import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();
String? token;

Future<void> getToken() async {
  dynamic userInfo = await storage.read(key: "login");
  token = json.decode(userInfo)['accessToken'];
}

Future<dynamic> postSchedule(Schedule schedule) async {
  try {
    print("postSchedule: ${schedule.toJson()}");
    var resBody = await http.post(
      Uri.parse("$baseUrl/api/schedules"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(schedule.toJson()),
    );
    dynamic res = jsonDecode(resBody.body);

    return res;
  } catch (e) {
    print("create schedule error: $e");
  }
}

Future<void> getSchedule(int scheduleId) async {
  try {
    final res = await http.get(Uri.parse("$baseUrl/api/schedules/$scheduleId"));

    print(res);
  } catch (e) {
    print("get schedule error: $e");
  }
}

Future<void> getRoute(String type, Place from, Place to) async {
  print(jsonEncode({
    "type": type,
    "from": {"lat": from.lat, "lng": from.lng},
    "to": {"lat": to.lat, "lng": to.lng}
  }));
  try {
    final resBody = await http.post(
      Uri.parse(("$baseUrl/api/schedules/route")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode({
        "type": type,
        "from": {"lat": from.lat, "lng": from.lng},
        "to": {"lat": to.lat, "lng": to.lng}
      }),
    );

    dynamic res = jsonDecode(resBody.body);
    print(res);
  } catch (e) {
    print("getRoute error: $e");
  }
}
