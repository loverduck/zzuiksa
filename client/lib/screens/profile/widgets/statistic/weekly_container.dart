import 'package:client/screens/profile/widgets/statistic/weekly_chart.dart';
import 'package:flutter/material.dart';

import 'package:client/constants.dart';

class WeeklyContainer extends StatelessWidget {
  const WeeklyContainer({super.key, required this.percent});
  final int percent;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Container(
      width: 340,
      height: 240,
      margin: EdgeInsets.all(8),
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
          border: Border.all(color: Constants.main600, width: 2),
          borderRadius: BorderRadius.circular(30),
          color: Constants.main100),
      child: ChartPage(),
    );
  }
}
