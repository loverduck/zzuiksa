import 'package:client/constants.dart';
import 'package:client/screens/profile/widgets/statistic/backup_button.dart';
import 'package:client/screens/profile/widgets/statistic/graph_container.dart';
import 'package:client/screens/profile/widgets/statistic/load_button.dart';
import 'package:client/screens/profile/widgets/statistic/weekly_container.dart';
import 'package:flutter/material.dart';

class MyStatistic extends StatefulWidget {
  const MyStatistic({super.key});

  @override
  State<MyStatistic> createState() => _MyStatisticState();
}

class _MyStatisticState extends State<MyStatistic> {
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Column(
      children: [
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 24, top: 12),
                child: Text('전체 달성률', style: textTheme.displaySmall))),
        GraphContainer(bgColor: Constants.main300, percent: 50),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 24, top: 12),
                child: Text('카테고리별 달성률', style: textTheme.displaySmall))),
        GraphContainer(category: '업무', bgColor: Constants.blue300, percent: 30),
        GraphContainer(
            category: '일상', bgColor: Constants.green300, percent: 40),
        GraphContainer(
            category: '기념일', bgColor: Constants.pink200, percent: 50),
        GraphContainer(
            category: '공부', bgColor: Constants.violet300, percent: 60),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: EdgeInsets.only(left: 24, top: 12),
                child: Text('주간 달성률', style: textTheme.displaySmall))),
        WeeklyContainer(percent: 90),
        SizedBox(height: 16),
        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          BackupButton(),
          LoadButton(),
        ]),
      ],
    );
  }
}
