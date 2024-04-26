import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'widgets/today.dart';
import 'widgets/completeRate.dart';
import 'widgets/sentences.dart';
import 'widgets/zzuiksa.dart';
import 'widgets/timeline.dart';

class DashboardScreen extends StatefulWidget {
  static const title = 'DashBoard';
  static const androidIcon = Icon(Icons.home);
  static const iosIcon = Icon(CupertinoIcons.music_note);

  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
            child: Column(
      children: [
        Container(
            margin: EdgeInsets.only(top: 80.0),
            padding: EdgeInsets.all(20.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Today(),
                CompleteRate(),
              ],
            )),
        Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.all(10.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Sentences(),
                Zzuiksa(),
              ],
            )),
        const Timeline(),
      ],
    )));
  }
}
