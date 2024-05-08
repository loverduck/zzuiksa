import 'package:flutter/material.dart';
import 'timeline_card.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});
  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
            padding: EdgeInsets.only(left: 48, right: 56, top: 20, bottom: 20),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('오늘의 일정', style: textTheme.displayMedium),
                  IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      iconSize: 32,
                      onPressed: () {
                        showDialog<void>(
                          context: context,
                          builder: (context) {
                            return AlertDialog(
                              title: Text('준비 중', style: textTheme.displayMedium),
                              content: Text('준비 중인 기능이에요!', style: textTheme.displaySmall),
                            );
                          },
                        );
                      }),
                ])),
        const TimelineCard(
          title: '내 생일',
          category: '기념일',
          startTime: '하루 종일',
          // preferenceChoices: ['A','B',],
        ),
        const TimelineCard(
            title: '알고리즘 스터디',
            category: '공부',
            startTime: '6:00 PM',
            endTime: '7:00 PM',
            alarm: true,
            comment: '슬슬 출발할 시간이에요!'),
        const TimelineCard(
            title: '비타민 C 젤리',
            category: '일정',
            startTime: '7:20 PM',
            alarm: false,
            comment: '아직 여유로워요!'),
      ],
    );
  }
}
