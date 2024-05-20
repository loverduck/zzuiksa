import 'package:client/constants.dart';
import 'package:client/screens/profile/service/statistic_api.dart';
import 'package:client/widgets/custom_button.dart';
import 'package:client/screens/profile/widgets/statistic/graph_container.dart';
import 'package:client/screens/profile/widgets/statistic/weekly_container.dart';
import 'package:client/screens/profile/model/statistic_model.dart';
import 'package:flutter/material.dart';

class MyStatistic extends StatefulWidget {
  const MyStatistic({super.key});

  @override
  State<MyStatistic> createState() => _MyStatisticState();
}

class _MyStatisticState extends State<MyStatistic> {
  late Statistic stt;
  late List<Category> category = [];
  late List<Daily> daily = [];

  late int totalPer = 0;
  late int workPer = -1;
  late int dailyPer = -1;
  late int anniversaryPer = -1;
  late int studyPer = -1;

  void _getStatistic() async {
    Statistic statistic = await getStatistic();
    if (statistic !=null) {
      setState(() {
        stt = statistic;
        totalPer = stt.total!.percent!.truncate();
        if (stt.category!=null) category = stt.category!.categories;
        if (stt.daily!=null) daily = stt.daily!.daylies;
        if (category.isNotEmpty) {
          for (int i = 0; i < category.length; i++) {
            switch (category[i].categoryId) {
              case 1: //일정
              dailyPer = category[i].percent!.truncate();
                break;
              case 2: //업무
                workPer = category[i].percent!.truncate();
                break;
              case 3: //기념일
                anniversaryPer = category[i].percent!.truncate();
                break;
              default://공부
                studyPer = category[i].percent!.truncate();
            }
          }
        }

      });
    }
  }

  @override
  void initState() {
    super.initState();
    stt = Statistic();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getStatistic();
    });
  }

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
        GraphContainer(bgColor: Constants.main300, percent: totalPer),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 12),
                child: Text('카테고리별 달성률', style: textTheme.displaySmall))),
        workPer==-1 ? Container() : GraphContainer(category: '업무', bgColor: Constants.blue300, percent: workPer),
        dailyPer==-1 ? Container() : GraphContainer(
            category: '일상', bgColor: Constants.green300, percent: dailyPer),
        anniversaryPer==-1 ? Container() : GraphContainer(
            category: '기념일', bgColor: Constants.pink200, percent: anniversaryPer),
        studyPer==-1? Container() : GraphContainer(
            category: '공부', bgColor: Constants.violet300, percent: studyPer),
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
                padding: const EdgeInsets.only(left: 24, top: 12),
                child: Text('주간 달성률', style: textTheme.displaySmall))),
        WeeklyContainer(percent: 90),
        const SizedBox(height: 16),
        // Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        //   CustomButton(
        //     text: '기록 백업하기',
        //     size: 'small',
        //     func: () {},
        //   ),
        //   CustomButton(
        //     text: '백업 불러오기',
        //     size: 'small',
        //     color: 200,
        //     func: () {},
        //   ),
        // ]),
      ],
    );
  }
}
