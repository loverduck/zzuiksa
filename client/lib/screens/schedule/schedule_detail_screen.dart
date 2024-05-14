import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/schedule_form_screen.dart';
import 'package:client/screens/schedule/service/schedule_api.dart';
import 'package:client/screens/schedule/widgets/detail/detail_container.dart';
import 'package:client/screens/schedule/widgets/snackbar_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math' as math;

import 'package:kakao_map_plugin/kakao_map_plugin.dart';

const double fontSizeMedium = 24.0;
const double fontSizeSmall = 20.0;

class ScheduleDetailScreen extends StatefulWidget {
  const ScheduleDetailScreen({super.key});

  @override
  State<ScheduleDetailScreen> createState() => _ScheduleDetailScreenState();
}

class _ScheduleDetailScreenState extends State<ScheduleDetailScreen> {
  late int scheduleId;
  late Schedule schedule;

  SizedBox textMargin = const SizedBox(
    width: 10.0,
  );

  SizedBox containerMargin = const SizedBox(
    height: 12.0,
  );

  TextStyle noneTextStyle = const TextStyle(
    color: Colors.black45,
    fontSize: fontSizeMedium,
  );

  Widget menuButton() {
    return PopupMenuButton(
      onSelected: (val) {
        if (val == "수정") {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return ScheduleFormScreen(
              selectedDay: DateTime.parse(schedule.startDate!),
              schedule: schedule,
            );
          }));
        }
      },
      itemBuilder: (context) => <PopupMenuItem>[
        const PopupMenuItem(
          value: "수정",
          child: Text("수정"),
        ),
        const PopupMenuItem(
          child: Text("삭제"),
        ),
      ],
    );
  }

  Future<void> deleteConfirmDialog(BuildContext context, int scheduleId) {
    print("delete confirm dialog $scheduleId");
    return showDialog<void>(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: const Text("해당 일정을 삭제하시겠습니까?"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text(
                  "취소",
                  style: TextStyle(
                    fontSize: 24.0,
                  ),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                  _deleteSchedule(context);
                },
                child: const Text(
                  "삭제하기",
                  style: TextStyle(
                    fontSize: 24.0,
                    color: Colors.red,
                  ),
                ),
              ),
            ],
          );
        });
  }

  void _getSchedule(int scheduleId, BuildContext context) async {
    Map<String, dynamic> res = await getSchedule(scheduleId);

    if (res['status'] == 'success') {
      setState(() {
        schedule = Schedule.fromJson(res['data']);
        schedule.scheduleId = scheduleId;
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SnackBarText(
            message: "로딩에 실패했습니다. 잠시 후 다시 시도해주세요",
          ),
        ),
      );
    }
  }

  void _deleteSchedule(BuildContext context) async {
    Map<String, dynamic> res = await deleteSchedule(scheduleId);

    if (res['status'] == 'success') {
      Navigator.pushNamed(context, '/calendar');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: SnackBarText(
            message: "일정 삭제에 실패했습니다. 다시 시도해주세요",
          ),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    schedule = Schedule();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (ModalRoute.of(context)?.settings.arguments != null) {
        final args = ModalRoute.of(context)?.settings.arguments as Map;
        scheduleId = args['scheduleId'];
        _getSchedule(scheduleId, context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Constants.main200,
        actions: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: menuButton(),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              // 제목
              DetailContainer(
                child: Row(
                  children: [
                    Container(
                      width: 24.0,
                      height: 24.0,
                      decoration: BoxDecoration(
                        color: categoryType[schedule.categoryId]?[1],
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    Text(
                      schedule.title == null ? "" : "${schedule.title}",
                      style: const TextStyle(
                        fontSize: fontSizeMedium,
                      ),
                    ),
                  ],
                ),
              ),
              containerMargin,
              // 날짜
              DetailContainer(
                child: Row(
                  children: [
                    const Icon(Icons.alarm),
                    textMargin,
                    schedule.startDate != null
                        ? DateTimeText(
                            date: "${schedule.startDate}",
                            time: schedule.startTime != null
                                ? "${schedule.startTime}"
                                : "00:00:00")
                        : Container(),
                    textMargin,
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                    ),
                    textMargin,
                    schedule.endDate != null
                        ? DateTimeText(
                            date: "${schedule.endDate}",
                            time: schedule.endTime != null
                                ? "${schedule.endTime}"
                                : "23:59:00")
                        : Container(),
                  ],
                ),
              ),
              containerMargin,
              // 반복 여부
              DetailContainer(
                child: Row(
                  children: [
                    Transform(
                      transform: Matrix4.identity()
                        ..rotateX(math.pi)
                        ..translate(0.0, -24.0),
                      child: const Icon(Icons.replay),
                    ),
                    textMargin,
                    schedule.repeat == null
                        ? Text(
                            "반복 없음",
                            style: noneTextStyle,
                          )
                        : RepeatText(
                            repeat: schedule.repeat!,
                          ),
                  ],
                ),
              ),
              containerMargin,
              // 알림 여부
              DetailContainer(
                child: Row(
                  children: [
                    const Icon(Icons.notifications_none),
                    textMargin,
                    schedule.alertBefore == null
                        ? Text(
                            "알림 없음",
                            style: noneTextStyle,
                          )
                        : Text(
                            "${schedule.alertBefore}분 전 알림",
                            style: const TextStyle(fontSize: fontSizeMedium),
                          ),
                  ],
                ),
              ),
              containerMargin,
              // 위치
              DetailContainer(
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.place_outlined),
                        textMargin,
                        Row(
                          children: [
                            const Text(
                              "장소: ",
                              style: TextStyle(
                                fontSize: fontSizeMedium,
                              ),
                            ),
                            schedule.toPlace != null
                                ? Text(
                                    schedule.toPlace!.name!,
                                    style: const TextStyle(
                                      fontSize: 24.0,
                                    ),
                                  )
                                : const Text(
                                    "장소 없음",
                                    style: TextStyle(
                                      fontSize: 24.0,
                                      color: Colors.black45,
                                    ),
                                  )
                          ],
                        ),
                      ],
                    ),
                    schedule.toPlace?.lat != null &&
                            schedule.toPlace?.lng != null
                        ? Column(
                            children: [
                              PlaceContainer(place: schedule.toPlace!),
                              const SizedBox(
                                height: 10.0,
                              )
                            ],
                          )
                        : Container(),
                  ],
                ),
              ),
              containerMargin,
              DetailContainer(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Icon(Icons.edit_outlined),
                        textMargin,
                        const Text(
                          "메모",
                          style: TextStyle(
                            fontSize: fontSizeMedium,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                      thickness: 1.0,
                    ),
                    schedule.memo == null || schedule.memo!.isEmpty
                        ? const Text(
                            "없음",
                            style: TextStyle(
                                fontSize: fontSizeMedium,
                                color: Colors.black54),
                          )
                        : Text(
                            schedule.memo!,
                            textAlign: TextAlign.left,
                            style: const TextStyle(
                              fontSize: fontSizeMedium,
                              color: Colors.black,
                            ),
                          ),
                  ],
                ),
              ),
              containerMargin,
              GestureDetector(
                onTap: () => deleteConfirmDialog(context, scheduleId),
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 12.0),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    border: Border.all(color: Colors.red, width: 2.0),
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: const Text(
                    "삭제하기",
                    style: TextStyle(
                      fontSize: 24.0,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
              containerMargin,
            ],
          ),
        ),
      ),
    );
  }
}

class RepeatText extends StatefulWidget {
  const RepeatText({super.key, required this.repeat});

  final Repeat repeat;

  @override
  State<RepeatText> createState() => _RepeatTextState();
}

class _RepeatTextState extends State<RepeatText> {
  @override
  Widget build(BuildContext context) {
    String text = "${cycleType[widget.repeat.cycle]} ";

    switch (widget.repeat.cycle) {
      case "MONTHLY":
      case "DAILY":
        text += "${widget.repeat.repeatAt}일";
        break;
      case "WEEKLY":
        int weeklyRepeatAt = widget.repeat.repeatAt!;
        for (int i = 1; i <= 7; i++) {
          if ((weeklyRepeatAt & (1 << i)) != 0) {
            text += "${week[i]}";
          }
        }
        break;
      case "YEARLY":
        String date = widget.repeat.repeatAt.toString().padLeft(4, "0");
        text += "${date.substring(0, 2)}월 ${date.substring(2, 4)}일";
        break;
    }

    text += "마다 반복";

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          text,
          style: const TextStyle(
            fontSize: fontSizeMedium,
          ),
        ),
        widget.repeat.endDate != null
            ? Text(
                "${widget.repeat.endDate}까지",
                style: const TextStyle(
                    fontSize: fontSizeSmall, color: Colors.black54),
              )
            : Container()
      ],
    );
  }
}

class DateTimeText extends StatefulWidget {
  const DateTimeText({
    super.key,
    required this.date,
    required this.time,
    this.schedule,
  });

  final String date;
  final String time;
  final Schedule? schedule;

  @override
  State<DateTimeText> createState() => _DateTimeTextState();
}

class _DateTimeTextState extends State<DateTimeText> {
  @override
  Widget build(BuildContext context) {
    DateTime? parsedTime;

    try {
      parsedTime = DateFormat("H:mm:ss").parse(widget.time);
    } catch (e) {
      parsedTime = DateTime.now();
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "${widget.date.split("-")[1]}월 ${widget.date.split("-")[2]}일",
          style: const TextStyle(
            height: 1.0,
            fontSize: fontSizeSmall,
          ),
        ),
        Text(
          DateFormat("h:mm a").format(parsedTime),
          style: const TextStyle(
            height: 1.0,
            fontSize: fontSizeMedium,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }
}

class PlaceContainer extends StatefulWidget {
  const PlaceContainer({super.key, required this.place});

  final Place place;

  @override
  State<PlaceContainer> createState() => _PlaceContainerState();
}

class _PlaceContainerState extends State<PlaceContainer> {
  late KakaoMapController mapController;
  List<Marker> marker = [];

  @override
  void initState() {
    super.initState();
    if (widget.place.lat != null && widget.place.lng != null) {
      marker.add(Marker(
          markerId: '0', latLng: LatLng(widget.place.lat!, widget.place.lng!)));
    }
  }

  @override
  Widget build(BuildContext context) {
    final LatLng latLng = LatLng(widget.place.lat!, widget.place.lng!);

    return SizedBox(
      height: 200.0,
      child: KakaoMap(
        onMapCreated: (controller) {
          mapController = controller;
          mapController.addMarker(markers: marker);
        },
        center: latLng,
        markers: marker,
      ),
    );
  }
}
