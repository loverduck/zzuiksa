class Gifticon {
  int? gifticonId;
  String? url;
  String? name;
  String? store;
  String? couponNum;
  String? endDate;
  String? isUsed;
  int? remainMoney;
  String? memo;

  Gifticon({
    this.gifticonId,
    this.url,
    this.name,
    this.store,
    this.couponNum,
    this.endDate,
    this.isUsed,
    this.remainMoney,
    this.memo
  });

  // factory Gifticon.fromJson(Map<String, dynamic> json) {
  //   return Gifticon(
  //     gifticonId: json['gifticonId'],
  //     url: json['url'],
  //     name: json['name'] != null ? Gifticon.fromJson(json['name']): null,
  //     store: json['store'] != null ? Gifticon.fromJson(json['name']): null,
  //     couponNum: json['couponNum'],
  //     endDate: json['endDate']!= null ? Gifticon.fromJson(json['name']): null,
  //     isUsed: json['isUsed'],
  //     remainMoney: json['remainMoney']!= null ? Gifticon.fromJson(json['name']): null,
  //     memo: json['memo']!= null ? Gifticon.fromJson(json['name']): null,
  //   );
  // }
  factory Gifticon.fromJson(Map<String, dynamic> json) {
    return Gifticon(
      gifticonId: json['gifticonId'] as int?,
      url: json['url'] as String?,
      name: json['name'] as String?,
      store: json['store'] as String?,
      couponNum: json['couponNum'] as String?,
      endDate: json['endDate'] as String?,
      isUsed: json['isUsed'] as String?,
      remainMoney: json['remainMoney'] as int?,
      memo: json['memo'] as String?,
    );
  }


  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['url'] = url;
  //   data['name'] = name;
  //   data['store'] = store;
  //   data['couponNum'] = couponNum;
  //   data['endDate'] = endDate;
  //   data['isUsed'] = isUsed;
  //   data['remainMoney'] = remainMoney;
  //   data['memo'] = memo;
  //   return data;
  // }
  Map<String, dynamic> toJson() {
    if (url == null || isUsed == null || couponNum == null) {
      throw Exception('url, isUsed, and couponNum cannot be null');
    }

    final Map<String, dynamic> data = <String, dynamic>{};
    // data['gifticonId'] = gifticonId;
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