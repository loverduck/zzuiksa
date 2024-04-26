import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CalendarScreen extends StatefulWidget {
  static const title = 'Calendar';
  static const androidIcon = Icon(Icons.insert_invitation);
  static const iosIcon = Icon(CupertinoIcons.news);

  const CalendarScreen({super.key});

  @override
  State<CalendarScreen> createState() => _CalendarScreenState();
}

class _CalendarScreenState extends State<CalendarScreen> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
            'Calendar Page'
        )
    );
  }
}
