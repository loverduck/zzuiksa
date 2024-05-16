import 'package:client/screens/dashboard/service/dashboard_api.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:client/constants.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    required this.schedule,
    this.alarm,
    this.comment,
    // required this.place,
    // required this.weather,
    // required this.preferenceChoices,
    super.key,
  });

  final Schedule schedule;
  final bool? alarm;
  final String? comment;
  // final String place;
  // final String weather;
  // final List<String> preferenceChoices;

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 340,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 8),
      decoration: BoxDecoration(
          color: categoryType[schedule.categoryId]![1],
          border: Border.all(color: Constants.main600, width: 2.5),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(schedule.title!, style: textTheme.displayMedium),
                Text(categoryType[schedule.categoryId]![0],
                    style: textTheme.displaySmall),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children: [
                  Icon(Icons.location_pin),
                  Text(' 올리브영'),
                ]),
                Row(children: [
                  Icon(Icons.sunny),
                  Text(' 18℃'),
                ]),
              ]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(schedule.startTime!, style: textTheme.bodyLarge),
              if (schedule.endTime != null)
                Text(schedule.endTime!, style: textTheme.bodyLarge),
            ],
          ),
          if (alarm != null && comment != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(children: [
                  alarm == true ? Icon(Icons.alarm_on) : Icon(Icons.alarm_off),
                  Text(' $comment', style: textTheme.displaySmall),
                ]),
                ElevatedButton(
                    onPressed: () {
                      print('complete button clicked');
                      endSchedule(schedule);
                    },
                    style: ButtonStyle(
                      fixedSize: MaterialStatePropertyAll(Size(80, 14)),
                      backgroundColor:
                          MaterialStateProperty.all(Constants.main100),
                      side: MaterialStateProperty.all(
                          BorderSide(width: 2.0, color: Constants.main600)),
                    ),
                    child: Text(
                      '완료!',
                      style: textTheme.displaySmall,
                    ))
              ],
            ),
        ],
      ),
    );
  }
}
