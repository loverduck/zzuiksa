
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
    return Statistic();
  }
}

class Total {
  int? count;
  int? done;
}

class Category {
  int? categoryId;
  String? name;
  int? count;
  int? done;
}

class Categories {
  List<Category>? categories;
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
});
}

class Daylies {
  List<Daily>? daylies;
}