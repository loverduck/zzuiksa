class Place {
  int? placeId; //장소 아이디
  String? name; //장소명
  double? lat; //위도
  double? lng; //경도

  Place({
    this.placeId,
    this.name,
    this.lat,
    this.lng,
  });

  Place.fromJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    name = json['name'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['placeId'] = placeId;
    data['name'] = name;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  String toString() {
    return "Place: {placeId: $placeId, name: $name, lat: $lat, lng: $lng}";
  }
}
