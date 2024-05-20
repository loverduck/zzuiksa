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

  // Place.fromJson(Map<String, dynamic> json) {
  //   placeId = json['placeId'];
  //   name = json['name'];
  //   lat = json['lat'];
  //   lng = json['lng'];
  // }

  factory Place.fromJson(Map<String, dynamic> json) {
    return Place(
      placeId: json['placeId'] as int?,
      name: json['name'] as String?,
      lat: json['lat'] as double?,
      lng: json['lng'] as double?,
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (placeId!=null) data['placeId'] = placeId;
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

class Places {
  List<Place> places;
  Places({required this.places});

  factory Places.fromJson(List<dynamic> json) {
    List<Place> jsonList = <Place>[];
    jsonList = json.map((i) => Place.fromJson(i)).toList();
    return Places(places: jsonList);
  }

  String toString() {
    return "Places: $places";
  }
}