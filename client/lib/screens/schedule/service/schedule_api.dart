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

Future<dynamic> getMonthSchedules(String from, String to) async {
  getToken();

  try {
    var uri = Uri.https(
        baseUrl.split("//")[1], "/api/schedules", {"from": from, "to": to});
    final res = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> json = jsonDecode(res.body);

    return json;
  } catch (e) {
    print("get month schedules error: $e");
  }
}

Future<dynamic> getSchedule(int scheduleId) async {
  getToken();

  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/schedules/$scheduleId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> json = jsonDecode(res.body);

    return json;
  } catch (e) {
    print("get schedule error: $e");
  }
}

Future<dynamic> getRoute(String type, Place from, Place to) async {
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

    Map<String, dynamic> res = jsonDecode(resBody.body);
    return res;
  } catch (e) {
    print("getRoute error: $e");
  }
}
