import 'dart:convert';

import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:http/http.dart' as http;

Future<void> postSchedule(Schedule schedule) async {
  try {
    final res = await http.post(
      Uri.parse("$baseUrl/api/schedules"),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(schedule.toJson()),
    );

    print(res);
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
