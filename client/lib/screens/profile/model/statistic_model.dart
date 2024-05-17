import 'dart:convert';

class Statistic {
  Total? total;
  Categories? category;
  Daylies? daily;

  Statistic({
    this.total,
    this.category,
    this.daily,
  });

  factory Statistic.fromJson(Map<String, dynamic> json) {
    return Statistic(
      total: Total.fromJson(json['total']),
      category: json['category']==null || json['category']==[] ? null : Categories.fromJson(json['category']),
      daily: json['daily']==null || json['daily']==[] ? null : Daylies.fromJson(json['daily']),
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['total'] = jsonEncode(total);
    data['category'] = jsonEncode(category);
    data['daily'] = jsonEncode(daily);
    return data;
  }

  @override
  String toString() {
    return "Statistic: {total: $total, category: $category, daily: $daily}";
  }
}

class Total {
  int? count;
  int? done;
  double? percent;

  Total({
    this.count,
    this.done,
    this.percent,
  });

  factory Total.fromJson(Map<String, dynamic> json) {
    return Total(
      count: json['count'],
      done: json['done'],
      percent: json['count']==0 ? null : (json['done']/json['count'])*100,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['done'] = done;
    return data;
  }

  @override
  String toString() {
    return "Total: {count: $count, done: $done, percent: $percent}";
  }
}


class Category {
  int? categoryId;
  String? name;
  int? count;
  int? done;
  double? percent;

  Category({
    this.categoryId,
    this.name,
    this.count,
    this.done,
    this.percent,
  });

  factory Category.fromJson(Map<String, dynamic> json) {
    return Category(
      categoryId: json['categoryId'],
      name: json['name'],
      count: json['count'],
      done: json['done'],
      percent: json['count']==0 ? null : (json['done']/json['count'])*100,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['categoryId'] = categoryId;
    data['name'] = name;
    data['count'] = count;
    data['done'] = done;
    return data;
  }

  @override
  String toString() {
    return "Category: {categoryId: $categoryId, name: $name, count: $count, done: $done, percent: $percent}";
  }
}

class Categories {
  List<Category> categories;

  Categories({required this.categories});

  factory Categories.fromJson(List<dynamic> json) {
    List<Category> jsonList = <Category>[];
    jsonList = json.map((i) => Category.fromJson(i)).toList();
    return Categories(categories: jsonList);
  }

  String toString() {
    return "Categories: $categories";
  }
}

class Daily {
  DateTime? date;
  String? weekday;
  int? count;
  int? done;

  Daily({
    this.date,
    this.weekday,
    this.count,
    this.done,
  });

  factory Daily.fromJson(Map<String, dynamic> json) {
    return Daily(
      date: json['date'] == null ? null : DateTime.parse(json['date']),
      weekday: json['weekday'],
      count: json['count'],
      done: json['done'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.date != null) {
      data['date'] = '${this.date!.year}-${this.date!.month}-${this.date!.day}';
    }
    data['weekday'] = weekday;
    data['count'] = count;
    data['done'] = done;
    return data;
  }

  @override
  String toString() {
    return "Daily: {date: $date, weekday: $weekday, count: $count, done: $done}";
  }
}

class Daylies {
  List<Daily> daylies;
  Daylies({required this.daylies});

  factory Daylies.fromJson(List<dynamic> json) {
    List<Daily> jsonList = <Daily>[];
    jsonList = json.map((i) => Daily.fromJson(i)).toList();
    return Daylies(daylies: jsonList);
  }

  String toString() {
    return "Daylies: $daylies";
  }
}
