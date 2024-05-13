class Schedule {
  int? scheduleId;
  int? categoryId = 1;
  String? title;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  int? alertBefore = 10000;
  String? memo = "";
  Place? toPlace;
  Place? fromPlace;
  Repeat? repeat;
  bool? isDone = false;

  Schedule(
      {this.scheduleId,
      this.categoryId,
      this.title,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.alertBefore,
      this.memo,
      this.toPlace,
      this.fromPlace,
      this.repeat,
      this.isDone});

  factory Schedule.fromJson(Map<String, dynamic> json) {
    return Schedule(
        scheduleId: json["scheduleId"],
        categoryId: json['categoryId'],
        title: json['title'],
        startDate: json['startDate'],
        endDate: json['endDate'],
        startTime: json['startTime'],
        endTime: json['endTime'],
        alertBefore: json['alertBefore'],
        memo: json['memo'],
        toPlace:
            json['toPlace'] != null ? Place.fromJson(json['toPlace']) : null,
        fromPlace: json['fromPlace'] != null
            ? Place.fromJson(json['fromPlace'])
            : null,
        repeat: json['repeat'],
        isDone: json['isDone']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['title'] = title;
    data['startDate'] = startDate;
    data['endDate'] = endDate;
    data['startTime'] = startTime;
    data['endTime'] = endTime;
    data['alertBefore'] = alertBefore;
    data['memo'] = memo;
    data['toPlace'] = toPlace?.toJson();
    data['fromPlace'] = fromPlace?.toJson();
    data['repeat'] = repeat;
    data['isDone'] = isDone;
    return data;
  }

  @override
  String toString() {
    return "Schedule: { scheduleId: $scheduleId, categoryId: $categoryId, title: $title, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, alertBefore: $alertBefore, memo: $memo, toPlace: $toPlace, fromPlace: $fromPlace, repeat: $repeat, isDone: $isDone }";
  }
}

class Place {
  String? name;
  double? lat;
  double? lng;

  Place({this.name, this.lat, this.lng});

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      name: json['name'],
      lat: json['lat'],
      lng: json['lng'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  String toString() {
    return "Place: { name: $name, lat: $lat, lng: $lng }";
  }
}

class Repeat {
  String? cycle;
  String? endDate;
  int? repeatAt;

  Repeat({this.cycle, this.endDate, this.repeatAt});

  factory Repeat.fromJson(Map<String, dynamic> json) {
    return Repeat(
      cycle: json['cycle'],
      endDate: json['endDate'],
      repeatAt: json['repeatAt'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cycle'] = cycle;
    data['endDate'] = endDate;
    data['repeatAt'] = repeatAt;
    return data;
  }

  @override
  String toString() {
    return "Repeat: { cycle: $cycle, endDate: $endDate, repeatAt: $repeatAt }";
  }
}
