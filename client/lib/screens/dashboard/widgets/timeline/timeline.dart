import 'package:flutter/material.dart';
import 'timeline_card.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:client/screens/schedule/schedule_form_screen.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});
  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  final scheduleList = [
    {
      "scheduleId": 1,
      "title": "내 생일",
      "categoryId": 3,
      "startTime": "하루 종일",
      // "preferenceChoices": ['A','B',],
    },
    {
      "scheduleId": 2,
      "title": "알고리즘 스터디",
      "categoryId": 4,
      "startTime": "6:00 PM",
      "endTime": "7:00 PM",
    },
    {
      "scheduleId": 3,
      "title": "비타민 C 젤리",
      "categoryId": 1,
      "startTime": "7:20 PM",
    },
    {
      "title": "야근 ㅜㅜ",
      "categoryId": 2,
      "startTime": "10:00 PM",
      "endTime": "12:00 PM",
    },
  ];

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 48, right: 56, top: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('오늘의 일정', style: textTheme.displayMedium),
                  IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      iconSize: 32,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => ScheduleFormScreen(
                                    selectedDay: DateTime.now())));
                      }),
                ])),
        Container(
            width: 340,
            height: scheduleList.length * 220,
            child: ListView.builder(
                itemCount: scheduleList.length,
                itemBuilder: (BuildContext context, int index) {
                  Schedule schedule = Schedule.fromJson(scheduleList[index]);
                  print(schedule.toString());
                  return TimelineCard(
                    schedule: schedule,
                      alarm: true,
                      comment: "슬슬 출발할 시간이에요!" //아직 여유로워요!
                      );
                })),
      ],
    );
  }
}
