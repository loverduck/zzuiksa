import 'package:client/screens/dashboard/widgets/timeline/complete_button.dart';
import 'package:flutter/material.dart';
import 'package:client/constants.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    required this.title,
    required this.category,
    required this.startTime,
    this.endTime,
    this.alarm,
    this.comment,
    // required this.place,
    // required this.weather,
    // required this.preferenceChoices,
    super.key,
  });

  final String title;
  final String category;
  final String startTime;
  final String? endTime;
  final bool? alarm;
  final String? comment;
  // final String place;
  // final String weather;
  // final List<String> preferenceChoices;

  @override
  Widget build(context) {
    final textTheme = Theme.of(context).textTheme;

    Color bgColor = Constants.green300;
    switch (category) {
      case '공부':
        bgColor = Constants.violet300;
        break;
      case '업무':
        bgColor = Constants.blue300;
        break;
      case '기념일':
        bgColor = Constants.pink200;
      default:
        break;
    }

    return Container(
      width: 340,
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.only(left: 24, right: 24, top: 16, bottom: 8),
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Constants.main600, width: 2.5),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Text(title, style: textTheme.displayMedium),
                Text(category, style: textTheme.displaySmall),
              ]),
              Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Row(children:[
                  Icon(Icons.location_pin),
                  Text(' 올리브영'),
                ]),
                Row(children:[
                  Icon(Icons.sunny),
                  Text(' 18℃'),
                ]),
              ]),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(startTime, style: textTheme.bodyLarge),
              if (endTime != null) Text(endTime!, style: textTheme.bodyLarge),
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
                CompleteButton()
              ],
            ),
        ],
      ),
    );
  }
}
