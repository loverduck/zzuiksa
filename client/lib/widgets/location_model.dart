import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';

class LocationModel extends ChangeNotifier {
  late Position _currentPostion;

  Position get currentPostion => _currentPostion;

  Future<void> getCurrentLocation() async {
    _currentPostion = await Geolocator.getCurrentPosition();
    notifyListeners();
  }
}

Future<Map<String, dynamic>> checkLocationPermission() async {
  PermissionStatus status = await Permission.location.status;

  if (status.isDenied) {
    status = await Permission.location.request();
  }

  if (status.isPermanentlyDenied) {
    return {"status": "deniedForever"};
  } else if (status.isGranted) {
    return {"status": "granted"};
  } else {
    return {"status": "denied"};
  }
}
