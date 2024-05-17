import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class LocationModel extends ChangeNotifier {
  late Position _currentPostion;

  Position get currentPostion => _currentPostion;

  Future<void> getCurrentLocation() async {
    _currentPostion = await Geolocator.getCurrentPosition();
    print("currentPosition: $_currentPostion");
    notifyListeners();
  }
}

Future<Map<String, dynamic>> checkLocationPermission() async {
  bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    return {"status": "serviceEnabled", "message": "위치 서비스가 비활성화되어 있습니다."};
  }

  LocationPermission permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      return {"status": "serviceEnabled", "message": "위치 정보 접근 권한이 거부되었습니다."};
    }
  }

  if (permission == LocationPermission.deniedForever) {
    return {
      "status": "deniedForever",
      "message": "위치 정보 접근 권한이 영구적으로 거부되었습니다. 설정에서 권한을 변경해주세요."
    };
  }

  return {"status": "success"};
}
