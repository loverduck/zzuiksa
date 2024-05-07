import 'package:client/constants.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/schedule_form_screen.dart';
import 'package:client/screens/schedule/widgets/detail/detail_container.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

const double fontSizeMedium = 24.0;
const double fontSizeSmall = 20.0;

class ScheduleDetailScreen extends StatefulWidget {
  const ScheduleDetailScreen({super.key});

  @override
  State<ScheduleDetailScreen> createState() => _ScheduleDetailScreenState();
}

class _ScheduleDetailScreenState extends State<ScheduleDetailScreen> {
  Schedule schedule = Schedule(
    title: "저녁 약속",
    startDate: "2024-04-27",
    startTime: "19:00",
    endDate: "2024-04-17",
    endTime: "20:00",
  );

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
        print(val);
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
                      decoration: const BoxDecoration(
                        color: Constants.green300,
                      ),
                    ),
                    const SizedBox(
                      width: 16.0,
                    ),
                    const Text(
                      "저녁 약속",
                      style: TextStyle(
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
                    const DateTimeText(date: "4월 17일", time: "7:00 PM"),
                    textMargin,
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black54,
                    ),
                    textMargin,
                    const DateTimeText(date: "4월 17일", time: "8:00 PM"),
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
  });

  final String date;
  final String time;

  @override
  State<DateTimeText> createState() => _DateTimeTextState();
}

class _DateTimeTextState extends State<DateTimeText> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          widget.date,
          style: const TextStyle(
            height: 1.0,
            fontSize: fontSizeSmall,
          ),
        ),
        Text(
          widget.time,
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
