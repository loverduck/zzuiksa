class Place {
  int? placeId; //장소 아이디
  String? name; //장소명
  String? address; //도로명주소
  double? lat; //위도
  double? lng; //경도

  Place({
    this.placeId,
    this.name,
    this.address,
    this.lat,
    this.lng,
  });

  Place.fromJson(Map<String, dynamic> json) {
    placeId = json['placeId'];
    name = json['name'];
    // address = json['address'];
    lat = json['lat'];
    lng = json['lng'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (placeId!=null) data['placeId'] = placeId;
    data['name'] = name;
    // if (address!=null) data['address'] = address;
    data['lat'] = lat;
    data['lng'] = lng;
    return data;
  }

  @override
  String toString() {
    return "Place: {placeId: $placeId, name: $name, address: $address, lat: $lat, lng: $lng}";
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