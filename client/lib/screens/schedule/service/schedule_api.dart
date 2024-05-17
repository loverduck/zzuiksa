import 'dart:convert';
import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

const storage = FlutterSecureStorage();
String? token;

Future<void> getToken() async {
  try {
    dynamic userInfo = await storage.read(key: "login");
    // token = userInfo;
    token = json.decode(userInfo)['accessToken'];
  } catch (e) {
    print("token error: $e");
  }
}

Future<dynamic> postSchedule(Schedule schedule) async {
  getToken();

  if (token == null) {
    print("토큰이 유효하지 않습니다.");
    return;
  }

  try {
    final res = await http.post(
      Uri.parse("$baseUrl/api/schedules"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(schedule.toJson()),
    );
    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));

    return json;
  } catch (e) {
    print("create schedule error: $e");
  }
}

Future<dynamic> postRecognize(Map<String, dynamic> body) async {
  try {
    final res = await http.post(
      Uri.parse("$baseUrl/api/schedules/recognize"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(body),
    );

    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));

    return json;
  } catch (e) {
    print("recognize error: $e");
  }
}

Future<dynamic> getMonthSchedules(String from, String to) async {
  await getToken();

  try {
    final uri = Uri.https(
        baseUrl.split("//")[1], "/api/schedules", {"from": from, "to": to});
    final res = await http.get(
      uri,
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));

    return json;
  } catch (e) {
    print("get month schedules error: $e");
  }
}

Future<dynamic> getSchedule(int scheduleId) async {
  try {
    final res = await http.get(
      Uri.parse("$baseUrl/api/schedules/$scheduleId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );

    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));

    return json;
  } catch (e) {
    print("get schedule error: $e");
  }
}

Future<dynamic> deleteSchedule(int scheduleId) async {
  try {
    final res = await http.delete(
      Uri.parse("$baseUrl/api/schedules/$scheduleId"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
    );
    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));

    return json;
  } catch (e) {
    print("delete schedule error: $e");
  }
}

Future<dynamic> patchSchedule(Schedule schedule) async {
  try {
    final res = await http.patch(
      Uri.parse(("$baseUrl/api/schedules/${schedule.scheduleId}")),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization': 'Bearer $token',
      },
      body: jsonEncode(schedule.toJson()),
    );
    Map<String, dynamic> json = jsonDecode(utf8.decode(res.bodyBytes));

    return json;
  } catch (e) {
    print("patch schedule error: $e");
  }
}

Future<dynamic> getRoute(String type, Place from, Place to) async {
  try {
    final res = await http.post(
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

    Map<String, dynamic> json = jsonDecode(res.body);
    return json;
  } catch (e) {
    print("getRoute error: $e");
  }
}
