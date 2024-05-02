import 'package:flutter/material.dart';
import 'package:client/constants.dart';

class TimelineCard extends StatelessWidget {
  const TimelineCard({
    required this.title,
    required this.category,
    required this.startTime,
    required this.comment,
    // required this.place,
    // required this.weather,
    // required this.preferenceChoices,
    super.key,
  });

  final String title;
  final String category;
  final String startTime;
  final String comment;
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
      margin: const EdgeInsets.only(bottom: 20.0),
      padding: const EdgeInsets.all(18.0),
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(color: Constants.main600, width: 2.5),
          borderRadius: BorderRadius.circular(30)),
      child: Column(
        children: [
          Text(title, style: textTheme.displayMedium),
          Text(category, style: textTheme.displaySmall),
          Text(startTime, style: textTheme.bodyLarge),
          Text(comment, style: textTheme.displaySmall),
        ],
      ),
    );
  }
}