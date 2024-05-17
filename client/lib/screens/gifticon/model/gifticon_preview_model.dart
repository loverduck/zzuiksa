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
      gifticonId: json['gifticonId'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      store: json['store'] as String?,
      endDate: json['endDate'] as String?,
      isUsed: json['isUsed'] as String?,
      remainMoney: json['remainMoney'] as int?,
    );
  }

  @override
  String toString() {
    return "GifticonPreview: url: $url, name: $name, store: $store, endDate: $endDate, isUsed: $isUsed, remainMoney: $remainMoney";
  }
}