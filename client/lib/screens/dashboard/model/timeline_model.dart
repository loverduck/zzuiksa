import 'dart:convert';
import 'package:client/screens/schedule/model/schedule_model.dart';

class Timeline {
  String? date; //"2024-05-16",
  int? doneScheduleCount;
  int? totalScheduleCount;
  String? comment;
  List<Summary>? schedules;

  Timeline({
    this.date,
    this.doneScheduleCount,
    this.totalScheduleCount,
    this.comment,
    this.schedules,
  });

  factory Timeline.fromJson(Map<String, dynamic> json) {
    return Timeline(
      date: json["date"],
      doneScheduleCount: json['doneScheduleCount'],
      totalScheduleCount: json['totalScheduleCount'],
      comment: json["comment"],
      schedules: json['schedules'] != null
          ? (json['schedules'] as List).cast<Map<String, dynamic>>()
          .map((json) => Summary.fromJson(json))
          .toList()
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['date'] = date;
    data['doneScheduleCount'] = doneScheduleCount;
    data['totalScheduleCount'] = totalScheduleCount;
    data['comment'] = comment;
    data['schedules'] = jsonEncode(schedules);
    return data;
  }

  @override
  String toString() {
    return "Timeline: { date: $date, doneScheduleCount: $doneScheduleCount, totalScheduleCount: $totalScheduleCount, comment: $comment, schedules: $schedules}";
  }
}

class Summary {
  Schedule? scheduleSummary;
  Weather? weatherInfo;

  Summary({this.scheduleSummary, this.weatherInfo});

  factory Summary.fromJson(Map<String, dynamic> json) {
    return Summary(
      scheduleSummary: json['scheduleSummary'] != null
          ? Schedule.fromJson(json['scheduleSummary'])
          : null,
      weatherInfo: json['weatherInfo'] != null
          ? Weather.fromJson(json['weatherInfo'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['scheduleSummary'] = scheduleSummary?.toJson();
    data['weatherInfo'] = weatherInfo?.toJson();
    return data;
  }

  @override
  String toString() {
    return "Summary: { scheduleSummary: $scheduleSummary, weatherInfo: $weatherInfo }";
  }
}

class Weather {
  int? maxPop;
  int? minTmp;
  int? maxTmp;
  String? weatherType;

  Weather({this.maxPop, this.minTmp, this.maxTmp, this.weatherType});

  factory Weather.fromJson(Map<String, dynamic> json) {
    return Weather(
      maxPop: json['maxPop'],
      minTmp: json['minTmp'],
      maxTmp: json['maxTmp'],
      weatherType: json['weatherType'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maxPop'] = maxPop;
    data['minTmp'] = minTmp;
    data['maxTmp'] = maxTmp;
    data['weatherType'] = weatherType;
    return data;
  }

  @override
  String toString() {
    return "Weather: { maxPop: $maxPop, minTmp: $minTmp, maxTmp: $maxTmp, weatherType: $weatherType }";
  }
}
