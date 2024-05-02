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
        Text('오늘의 일정', style: textTheme.displayMedium),
        const TimelineCard(
          title:'내 생일',
          category:'기념일',
          startTime:'하루 종일',
          comment:'',
          // preferenceChoices: ['A','B',],
        ),
        const TimelineCard(
            title: '알고리즘 스터디',
            category: '공부',
            startTime: '6:00 PM',
            comment: '슬슬 출발할 시간이에요!'
        ),
        const TimelineCard(
            title: '비타민 C 젤리',
            category: '일정',
            startTime: '7:20 PM',
            comment: '아직 여유로워요!'
        ),
      ],
    );
  }
}
