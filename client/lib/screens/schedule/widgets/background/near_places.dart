import 'dart:async';
import 'dart:convert';
import 'dart:ui';

import 'package:client/screens/dashboard/model/dashboard_model.dart';
import 'package:client/screens/dashboard/service/dashboard_api.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;

final FlutterLocalNotificationsPlugin _local =
    FlutterLocalNotificationsPlugin();
Position? lastPosition;

Future<void> initializeService() async {
  final service = FlutterBackgroundService();
  print("백그라운드 초기화");

  await service.configure(
      iosConfiguration: IosConfiguration(),
      androidConfiguration: AndroidConfiguration(
          onStart: onStart, isForegroundMode: true, autoStart: true));

  service.startService();
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  DartPluginRegistrant.ensureInitialized();
  if (service is AndroidServiceInstance) {
    service.on("setAsForeground").listen((event) {
      service.setAsForegroundService();
    });
    service.on("setAsBackground").listen((event) {
      service.setAsBackgroundService();
    });
  }

  service.on("stopService").listen((event) {
    service.stopSelf();
  });

  List<Summary> todayScheduls = await getTodaySchedules();

  service.on("updateSchedule").listen((event) async {
    print("일정 수정, 백그라운드 업데이트");
    todayScheduls = await getTodaySchedules();
  });

  await dotenv.load(fileName: 'local.env');

  NotificationDetails details = const NotificationDetails(
    android: AndroidNotificationDetails(
      "test",
      "test",
      importance: Importance.max,
      priority: Priority.high,
    ),
  );

  // 사용자의 움직임을 판단할 거리 500m
  double movementDiff = 500;

  if (todayScheduls.isNotEmpty) {
    Timer.periodic(
      const Duration(minutes: 5),
      (timer) async {
        Position currentPosition = await Geolocator.getCurrentPosition();

        if (service is AndroidServiceInstance) {
          if (await service.isForegroundService()) {
            for (Summary schedule in todayScheduls) {
              if (schedule.scheduleSummary!.toPlace?.name != null) {
                Map<String, dynamic> res = await searchPlace(
                    schedule.scheduleSummary!.toPlace!, currentPosition);
                if (res["status"] == "success") {
                  Place near = res["place"];
                  await _local.show(
                      schedule.scheduleSummary!.scheduleId!,
                      "${near.name}을 지나고 있어요!",
                      "${schedule.scheduleSummary?.title!}을 잊지 마세요",
                      details);
                }
              }
            }
          }
        }

        if (lastPosition != null) {
          double distance = Geolocator.distanceBetween(
              lastPosition!.latitude,
              lastPosition!.longitude,
              currentPosition.latitude,
              currentPosition.longitude);

          if (distance >= movementDiff) {
            print("움직이는 중");

            if (service is AndroidServiceInstance) {
              if (await service.isForegroundService()) {
                for (Summary schedule in todayScheduls) {
                  if (schedule.scheduleSummary!.toPlace?.name != null) {
                    Map<String, dynamic> res = await searchPlace(
                        schedule.scheduleSummary!.toPlace!, currentPosition);
                    if (res["status"] == "success") {
                      Place near = res["place"];
                      await _local.show(
                          schedule.scheduleSummary!.scheduleId!,
                          "${near.name}을 지나고 있어요!",
                          "${schedule.scheduleSummary?.title!}을 잊지 마세요",
                          details);
                    }
                  }
                }
              }
            }
          }
        }

        lastPosition = currentPosition;
      },
    );
  }
}

Future<List<Summary>> getTodaySchedules() async {
  final res = await getTimeline();

  return res.schedules.summaries;
}

Future<Map<String, dynamic>> searchPlace(Place place, Position current) async {
  final query = {
    "query": place.name,
    "x": current.longitude.toString(),
    "y": current.latitude.toString(),
    "radius": 300.toString(),
  };

  try {
    final res = await http.get(
        Uri.https("dapi.kakao.com", "/v2/local/search/keyword.json", query),
        headers: {
          "Authorization": "KakaoAK ${dotenv.get("KAKAO_REST_API_KEY")}"
        });

    Map<String, dynamic> json = jsonDecode(res.body);

    if (json["documents"].length > 0) {
      Map<String, dynamic> searchRes = json["documents"][0];

      if (place.name == searchRes["place_name"]) {
        return {"status": "success", "place": place};
      }
    }

    return {"status": "failed"};
  } catch (e) {
    print("search error: $e");
    return {"status": "failed"};
  }
}
