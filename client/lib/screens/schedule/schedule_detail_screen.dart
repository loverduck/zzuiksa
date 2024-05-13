import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/schedule_form_screen.dart';
import 'package:client/screens/schedule/service/schedule_api.dart';
import 'package:client/screens/schedule/widgets/detail/detail_container.dart';
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

  void _getSchedule(int scheduleId) async {
    print("api 연결");
    Map<String, dynamic> res = await getSchedule(scheduleId);

    if (res['status'] == 'success') {
      setState(() {
        schedule = Schedule.fromJson(res['data']);
        schedule.scheduleId = scheduleId;
      });
      print("schedule: $schedule");
    } else {
      print("다시 시도해주세요");
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
        _getSchedule(scheduleId);
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
                      "${schedule.title}",
                      style: const TextStyle(
                        fontSize: 24.0,
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
                    schedule.startDate != null && schedule.startTime != null
                        ? DateTimeText(
                            date: "${schedule.startDate}",
                            time: "${schedule.startTime}")
                        : Container(),
                    textMargin,
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                    ),
                    textMargin,
                    schedule.endDate != null && schedule.endTime != null
                        ? DateTimeText(
                            date: "${schedule.endDate}",
                            time: "${schedule.endTime}")
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
                    Text(
                      "반복 없음",
                      style: noneTextStyle,
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
                    Text(
                      "알림 없음",
                      style: noneTextStyle,
                    ),
                  ],
                ),
              ),
              containerMargin,
              // 위치
              DetailContainer(
                child: Row(
                  children: [
                    const Icon(Icons.place_outlined),
                    textMargin,
                    Text(
                      "장소 없음",
                      style: noneTextStyle,
                    ),
                  ],
                ),
              ),
              containerMargin,
              DetailContainer(
                child: Column(
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
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
    print(widget.schedule);
    DateTime? parsedTime;

    try {
      parsedTime = DateFormat("H:mm:ss").parse(widget.time);
    } catch (e) {
      print("schedule detail 시간 파싱 실패");
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
