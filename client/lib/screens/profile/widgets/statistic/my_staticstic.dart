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

    return Container(child: Text('statistic'));
  }
}
