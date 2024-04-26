import 'package:flutter/material.dart';

class Today extends StatefulWidget {
  const Today({super.key});
  @override
  State<Today> createState() => _TodayState();
}

class _TodayState extends State<Today> {
  DateTime now = DateTime.now();

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Center(
        child: Text('${now.month}월 ${now.day}일',
            style: textTheme.displayLarge)
    );
  }
}
