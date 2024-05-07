class Schedule {
  int? categoryId = 1;
  String? title;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  int? alertBefore;
  String? memo = "";
  Place? toPlace;
  Place? fromPlace;
  bool? repeat = false;
  bool? isDone = false;

  Schedule(
      {this.categoryId,
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

  Schedule.fromJson(Map<String, dynamic> json) {
    categoryId = json['categoryId'];
    title = json['title'];
    startDate = json['startDate'];
    endDate = json['endDate'];
    startTime = json['startTime'];
    endTime = json['endTime'];
    alertBefore = json['alertBefore'];
    memo = json['memo'];
    // toPlace = json['toPlace'];
    // fromPlace = json['fromPlace'];
    toPlace = json['toPlace'] != null ? Place.fromJson(json['toPlace']) : null;
    fromPlace =
        json['fromPlace'] != null ? Place.fromJson(json['fromPlace']) : null;
    // repeat = json['repeat'] != null ? repeat.fromJson(json['repeat']) : null;
    repeat = json['repeat'];
    isDone = json['isDone'];
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
    // data['toPlace'] = toPlace;
    // data['fromPlace'] = fromPlace;
    if (toPlace != null) {
      data['toPlace'] = toPlace!.toJson();
    }
    if (fromPlace != null) {
      data['fromPlace'] = fromPlace!.toJson();
    }
    // if (repeat != null) {
    //   data['repeat'] = repeat!.toJson();
    // }
    data['repeat'] = repeat;
    data['isDone'] = isDone;
    return data;
  }

  @override
  String toString() {
    return "Schedule: {categoryId: $categoryId, title: $title, startDate: $startDate, endDate: $endDate, startTime: $startTime, endTime: $endTime, alertBefore: $alertBefore, memo: $memo, toPlace: $toPlace, fromPlace: $fromPlace}, repeat: $repeat, isDone: $isDone";
  }
}

class Place {
  String? name;
  String? lat;
  String? lng;

  Place({this.name, this.lat, this.lng});

  Place.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['name'] = name;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }
}

class repeat {
  String? cycle;
  String? endDate;
  int? repeatTerm;
  int? repeatAt;

  repeat({this.cycle, this.endDate, this.repeatTerm, this.repeatAt});

  repeat.fromJson(Map<String, dynamic> json) {
    cycle = json['cycle'];
    endDate = json['endDate'];
    repeatTerm = json['repeatTerm'];
    repeatAt = json['repeatAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['cycle'] = cycle;
    data['endDate'] = endDate;
    data['repeatTerm'] = repeatTerm;
    data['repeatAt'] = repeatAt;
    return data;
  }
}
