class GifticonPreview {
  int? id;
  String? url;
  String? name;
  String? store;
  String? endDate;
  String? isUsed;

  GifticonPreview({
    this.id,
    this.url,
    this.name,
    this.store,
    this.endDate,
    this.isUsed,
  });

  factory GifticonPreview.fromJson(Map<String, dynamic> json) {
    return GifticonPreview(
      id: json['gifticonId'],
      url: json['url'],
      name: json['name'],
      store: json['store'],
      endDate: json['endDate'],
      isUsed: json['isUsed'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    data['store'] = store;
    data['endDate'] = endDate;
    data['isUsed'] = isUsed;
    return data;
  }

  @override
  String toString() {
    return "GifticonPreview: url: $url, name: $name, store: $store, endDate: $endDate, isUsed: $isUsed";
  }
}