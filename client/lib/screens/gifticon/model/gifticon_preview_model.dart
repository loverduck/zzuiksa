class GifticonPreview {
  int? gifticonId;
  String? url;
  String? name;
  String? store;
  String? endDate;
  String? isUsed;
  int? remainMoney;

  GifticonPreview({
    this.gifticonId,
    this.url,
    this.name,
    this.store,
    this.endDate,
    this.isUsed,
    this.remainMoney,
  });

  factory GifticonPreview.fromJson(Map<String, dynamic> json) {
    return GifticonPreview(
      gifticonId: json['gifticonId'],
      url: json['url'],
      name: json['name'],
      store: json['store'],
      endDate: json['endDate'],
      isUsed: json['isUsed'],
      remainMoney: json['remainMoney'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    data['store'] = store;
    data['endDate'] = endDate;
    data['isUsed'] = isUsed;
    data['remainMoney'] = remainMoney;
    return data;
  }

  @override
  String toString() {
    return "GifticonPreview: url: $url, name: $name, store: $store, endDate: $endDate, isUsed: $isUsed, remainMoney: $remainMoney";
  }
}