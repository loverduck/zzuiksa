import 'package:flutter/material.dart';
import 'package:client/constants.dart';
import 'package:client/screens/dashboard/model/dashboard_model.dart';
import 'package:client/screens/dashboard/service/dashboard_api.dart';
import 'package:client/screens/schedule/schedule_form_screen.dart';
import 'timeline_card.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  late Dashboard dashboard;
  late List<Summary> scheduleList;

  void _getTimeline() async {
    dashboard = await getTimeline();
    setState(() {
      scheduleList = dashboard.schedules!.summaries;
    });
  }

  @override
  void initState() {
    super.initState();
    // dashboard = widget.dashboard;
    scheduleList = [];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _getTimeline();
    });
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: 48, right: 56, top: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('오늘의 일정', style: textTheme.displayMedium),
              IconButton(
                  icon: Icon(Icons.add_circle_outline),
                  iconSize: 32,
                  color: Constants.main600,
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            ScheduleFormScreen(selectedDay: DateTime.now()),
                      ),
                    );
                  }),
            ],
          ),
        ),
        scheduleList.length == 0
            ? Container(
                width: 340,
                height: 80,
                margin: EdgeInsets.all(24),
                decoration: BoxDecoration(
                    color: Constants.main100,
                    border: Border.all(color: Constants.main600, width: 2.5),
                    borderRadius: BorderRadius.circular(32)),
                child: Center(
                  child: Text('오늘의 일정을 모두 완료하셨나요?',
                      style: textTheme.displayMedium),
                ),
              )
            : Container(
                width: 340,
                height: scheduleList.length * 240,
                child: ListView.builder(
                    itemCount: scheduleList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Summary summary = scheduleList[index];
                      print(summary);
                      return TimelineCard(summary: summary);
                    }),
              ),
      ],
    );
  }
}
