import 'package:flutter/material.dart';

import 'widgets/today.dart';
import 'widgets/completeRate.dart';
import 'widgets/sentences.dart';
import 'widgets/zzuiksa.dart';
import 'widgets/timeline/timeline.dart';
import '../login/logout_button.dart';

class DashboardScreen extends StatefulWidget {
  static const title = 'DashBoard';
  static const androidIcon = Icon(Icons.home);

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
            padding: EdgeInsets.only(left: 40, right: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Today(),
                ChartPage(),
              ],
            )),
        Container(
            margin: EdgeInsets.all(10.0),
            padding: EdgeInsets.only(right: 20.0),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Sentences(),
                Zzuiksa(),
              ],
            )),
        const Timeline(),
        const LogoutButton(),
        const SizedBox(height: 32)
      ],
    )));
  }
}
