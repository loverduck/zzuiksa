import 'dart:convert';
import 'package:client/screens/schedule/model/schedule_model.dart';

class Dashboard {
  String? date; //"2024-05-16",
  int? doneScheduleCount;
  int? totalScheduleCount;
  String? comment;
  Summaries? schedules;

  Dashboard({
    this.date,
    this.doneScheduleCount,
    this.totalScheduleCount,
    this.comment,
    this.schedules,
  });

  factory Dashboard.fromJson(Map<String, dynamic> json) {
    // List<Summary> list = <Summary>[];
    // list = json['schedules'].map((i) => Summary.fromJson(i)).toList();

    return Dashboard(
      date: json["date"],
      doneScheduleCount: json['doneScheduleCount'],
      totalScheduleCount: json['totalScheduleCount'],
      comment: json["comment"],
      schedules: json['schedules'] != null
          ? Summaries.fromJson(json['schedules'])
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
    return "Dashboard: { date: $date, doneScheduleCount: $doneScheduleCount, totalScheduleCount: $totalScheduleCount, comment: $comment, schedules: $schedules}";
  }
}

class Summaries {
  List<Summary> summaries;
  Summaries({required this.summaries});

  factory Summaries.fromJson(List<dynamic> json) {
    List<Summary> jsonList = <Summary>[];
    jsonList = json.map((i) => Summary.fromJson(i)).toList();
    return Summaries(summaries: jsonList);
  }

  String toString() {
    return "Summaries: $summaries";
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
