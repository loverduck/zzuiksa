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
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest.dart' as tz;

final FlutterLocalNotificationsPlugin _local =
    FlutterLocalNotificationsPlugin();
Position? lastPosition;
NotificationDetails details = const NotificationDetails(
  android: AndroidNotificationDetails(
    "test",
    "test",
    importance: Importance.max,
    priority: Priority.high,
  ),
);
final seoul = tz.getLocation("Asia/Seoul");

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
  tz.initializeTimeZones();
  tz.setLocalLocation(seoul);

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

  service.on("setAlert").listen((event) {
    setScheduleAlert(
        Schedule.fromJson(event?["schedule"]), event?["scheduleId"]);
  });

  service.on("cancelAlert").listen((event) {
    int? scheduleId = event?["scheduleId"];

    if (scheduleId != null) {
      _local.cancel(event?["scheduleId"]);
    }
  });

  List<Summary> todayScheduls = await getTodaySchedules();

  service.on("updateSchedule").listen((event) async {
    todayScheduls = await getTodaySchedules();
  });

  await dotenv.load(fileName: 'local.env');

  // 사용자의 움직임을 판단할 거리 300m
  double diffMin = 300;
  double diffMax = 700;

  if (todayScheduls.isNotEmpty) {
    Timer.periodic(
      const Duration(seconds: 5),
      (timer) async {
        Position currentPosition = await Geolocator.getCurrentPosition();

        if (service is AndroidServiceInstance) {
          if (await service.isForegroundService()) {
            for (Summary schedule in todayScheduls) {
              if (schedule.scheduleSummary!.toPlace?.name != null &&
                  !schedule.scheduleSummary!.isDone!) {
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

        // if (lastPosition != null) {
        //   double distance = Geolocator.distanceBetween(
        //       lastPosition!.latitude,
        //       lastPosition!.longitude,
        //       currentPosition.latitude,
        //       currentPosition.longitude);

        //   if (distance >= diffMin && distance <= diffMax) {
        //     print("움직이는 중");

        //     if (service is AndroidServiceInstance) {
        //       if (await service.isForegroundService()) {
        //         for (Summary schedule in todayScheduls) {
        //           if (schedule.scheduleSummary!.toPlace?.name != null &&
        //               schedule.scheduleSummary!.isDone == false) {
        //             Map<String, dynamic> res = await searchPlace(
        //                 schedule.scheduleSummary!.toPlace!, currentPosition);
        //             if (res["status"] == "success") {
        //               Place near = res["place"];
        //               await _local.show(
        //                   schedule.scheduleSummary!.scheduleId!,
        //                   "${near.name}을 지나고 있어요!",
        //                   "${schedule.scheduleSummary?.title!}을 잊지 마세요!",
        //                   details);
        //             }
        //           }
        //         }
        //       }
        //     }
        //   }
        // }

        // lastPosition = currentPosition;
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
    "radius": 50.toString(),
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

Future<void> setScheduleAlert(Schedule schedule, int scheduleId) async {
  DateTime startTime = DateFormat("yyyy-MM-dd HH:mm")
      .parse("${schedule.startDate!} ${schedule.startTime ?? "00:00:00"}");
  tz.TZDateTime scheduleTime = tz.TZDateTime(seoul, startTime.year,
          startTime.month, startTime.day, startTime.hour, startTime.minute)
      .subtract(Duration(minutes: schedule.alertBefore!));

  await _local.zonedSchedule(
    scheduleId,
    "${schedule.title} 준비하세요!",
    "오늘 ${DateFormat("HH시 mm분").format(startTime)}에 일정이 있어요",
    scheduleTime,
    details,
    uiLocalNotificationDateInterpretation:
        UILocalNotificationDateInterpretation.absoluteTime,
    matchDateTimeComponents: null,
  );
}
