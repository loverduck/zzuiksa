class Gifticon {
  int? id;
  String? url;
  String? name;
  String? store;
  String? couponNum;
  String? endDate;
  String? isUsed;
  int? remainMoney;
  String? memo;

  Gifticon({
    this.id,
    this.url,
    this.name,
    this.store,
    this.couponNum,
    this.endDate,
    this.isUsed,
    this.remainMoney,
    this.memo
  });

  factory Gifticon.fromJson(Map<String, dynamic> json) {
    return Gifticon(
      id: json['gifticonId'],
      url: json['url'],
      name: json['name'],
      store: json['store'],
      couponNum: json['couponNum'],
      endDate: json['endDate'],
      isUsed: json['isUsed'],
      remainMoney: json['remainMoney'],
      memo: json['memo'],
    );
  }
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['name'] = name;
    data['store'] = store;
    data['couponNum'] = couponNum;
    data['endDate'] = endDate;
    data['isUsed'] = isUsed;
    data['remainMoney'] = remainMoney;
    data['memo'] = memo;
    return data;
  }

  @override
  String toString() {
    return "Gifticon: url: $url, name: $name, store: $store, couponNum: $couponNum, endDate: $endDate, isUsed: $isUsed, remainMoney: $remainMoney, memo: $memo";
  }
}