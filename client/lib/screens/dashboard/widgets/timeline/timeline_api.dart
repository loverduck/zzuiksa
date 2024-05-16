import 'package:client/screens/dashboard/service/dashboard_api.dart';
import 'package:flutter/material.dart';
import 'package:client/screens/dashboard/model/timeline_model.dart';

class TimelineApi extends StatefulWidget {
  const TimelineApi({super.key});

  @override
  State<TimelineApi> createState() => _TimelineApiState();
}

class _TimelineApiState extends State<TimelineApi> {
  late Timeline timeline;

  void _getTimeline() async {
    Timeline res = await getTimeline();
    print("getTimeline api success: $res");
    setState(() {
      timeline = res;
    });
  }

  @override
  void initState() {
    super.initState();
    timeline = Timeline();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTimeline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Center(
        child: Text(
      "timeline api",
      style: textTheme.displayMedium,
    ));
  }
}
