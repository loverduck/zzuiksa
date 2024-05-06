class Gifticon {
  int? id;
  String? name;
  String? url;
  String? store;
  String? couponNum;
  String? endDate;
  String? isUsed;
  int? remainMoney;
  String? memo;

  Gifticon({
    this.id,
    this.name,
    this.url,
    this.store,
    this.couponNum,
    this.endDate,
    this.isUsed,
    this.remainMoney,
    this.memo
  });

  factory Gifticon.fromJson(Map<String, dynamic> json) {
    return Gifticon(
      id: json['id'],
      name: json['name'],
      url: json['url'],
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
    data['name'] = name;
    data['url'] = url;
    data['store'] = store;
    data['couponNum'] = couponNum;
    data['endDate'] = endDate;
    data['isUsed'] = isUsed;
    if (remainMoney != null) {
      data['remainMoney'] = remainMoney;
    }
    if (memo != null) {
      data['memo'] = memo;
    }
    return data;
  }

  @override
  String toString() {
    return "Gifticon: name: $name, url: $url, store: $store, couponNum: $couponNum, endDate: $endDate, isUsed: $isUsed, remainMoney: $remainMoney, memo: $memo";
  }
}