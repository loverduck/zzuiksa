import 'package:flutter/material.dart';
import 'package:client/constants.dart';

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
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 20.0),
          padding: EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              color: Constants.pink200,
              border: Border.all(color: Constants.main600, width: 2.5),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Text('내 생일', style: textTheme.displayMedium),
              Text('기념일', style: textTheme.displaySmall),
              Text('하루 종일', style: textTheme.displayMedium),
            ],
          ),
        ),
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 20.0),
          padding: EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              color: Constants.violet300,
              border: Border.all(color: Constants.main600, width: 2.5),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Text('알고리즘 스터디', style: textTheme.displayMedium),
              Text('공부', style: textTheme.displaySmall),
              Text('6:00 PM', style: textTheme.bodyLarge),
              Text('슬슬 출발할 시간이에요!', style: textTheme.displaySmall),
            ],
          ),
        ),
        Container(
          width: 340,
          margin: EdgeInsets.only(bottom: 20.0),
          padding: EdgeInsets.all(18.0),
          decoration: BoxDecoration(
              color: Constants.green300,
              border: Border.all(color: Constants.main600, width: 2.5),
              borderRadius: BorderRadius.circular(30)),
          child: Column(
            children: [
              Text('비타민 C 젤리', style: textTheme.displayMedium),
              Text('일정', style: textTheme.displaySmall),
              Text('7:20 PM', style: textTheme.bodyLarge),
              Text('아직 여유로워요!', style: textTheme.displaySmall),
            ],
          ),
        ),
      ],
    );
  }
}
