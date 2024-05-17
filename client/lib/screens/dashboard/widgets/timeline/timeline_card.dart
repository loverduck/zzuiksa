import 'package:client/screens/dashboard/service/dashboard_api.dart';
import 'package:client/screens/schedule/model/schedule_model.dart';
import 'package:flutter/material.dart';
import 'package:client/constants.dart';
import 'package:intl/intl.dart';

import '../../model/dashboard_model.dart';

class TimelineCard extends StatelessWidget {
  final Summary summary;

  const TimelineCard({
    required this.summary,
    super.key,
  });

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: 340,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 8),
      decoration: BoxDecoration(
          color: categoryType[summary.scheduleSummary?.categoryId]![1],
          border: Border.all(color: Constants.main600, width: 2.5),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(summary.scheduleSummary!.title!,
                    style: textTheme.displayMedium),
                Text(categoryType[summary.scheduleSummary?.categoryId]![0],
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
              Text(summary.scheduleSummary!.startTime!,
                  style: textTheme.bodyLarge),
              if (summary.scheduleSummary!.endTime != null)
                Text(summary.scheduleSummary!.endTime!,
                    style: textTheme.bodyLarge),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(children: [
                Icon(Icons.alarm_on),
                Text(' 출발할 시간이에요!', style: textTheme.displaySmall),
              ]),
              ElevatedButton(
                  onPressed: () {
                    print('complete button clicked');
                    endSchedule(summary.scheduleSummary!.scheduleId!);
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
